;; -*- lexical-binding: t; -*-
;;
(defmacro systype-switch (with-linux with-windows with-bsd)
  `(pcase system-type
     ('gnu/linux ,with-linux)
     ('windows ,with-windows)
     ('berkeley-unix ,with-bsd)))
;; a crappy implementation of a parser
(defun parse-simple-conf (file)
  (with-temp-buffer
    (insert-file-contents file)
    (mapcar (lambda (x)
              (let ((lst (mapcar (lambda (x)
                                   (car (read-from-string x)))
                                 (split-string x "=" t))))
                (cons (car lst)
                      (cadr lst))))
            (split-string (buffer-string)
                          (systype-switch "\n" "\r\n" "\n")
                          t))))
;; system info
(setq distro
      (systype-switch
       (alist-get 'ID (parse-simple-conf "/etc/os-release"))
       'windows-nt
       (with-temp-buffer
         (insert-file-contents "/etc/motd")
         (current-word))))
;; encoding
(prefer-coding-system 'utf-8)
(setq file-name-coding-system 'utf-8)
;; company-statistics-cache check
;; and activate company-mode globally
;; (let ((f "~/.emacs.d/company-statistics-cache.el"))
;;   (when (not (file-exists-p f))
;;     (write-region "" nil f))
;;   (load-file f)
;;   (add-hook 'after-init-hook #'company-statistics-mode))
;;; global hooks
(add-hook 'prog-mode-hook #'linum-mode)
;;; archiver, needs for 'windows-nt
(when (eq 'windows-nt system-type)
  (add-to-list 'exec-path "C:/Program Files/7-Zip"))

;;; Whether confirmation is requested before visiting a new file or buffer.
;;; If nil, confirmation is not requested.
(setq confirm-nonexistent-file-or-buffer nil)
;;; -----------------------------------
;; company-mode and company statistics
(require 'company)
(eval-after-load 'company
  (global-company-mode 1))
;; (eval-after-load 'company-statistics
;;   (company-statistics-mode 1))
(add-hook 'after-init-hook 'global-company-mode)
;; lua
(add-hook 'lua-mode-hook
          (lambda () (setq-local company-backends '(company-lua))))
;;; rainbow mode
(seq-doseq (m '(css html emacs-lisp))
  (add-hook (append-sym-postfix m "-mode-hook") #'rainbow-mode))
;;; eldoc mode
(seq-doseq (m '(emacs-lisp c))
  (add-hook (append-sym-postfix m "-mode-hook") #'eldoc-mode))
;;; -----------------------------------
;;; fictionbook support
(add-to-list 'load-path "~/.emacs.d/el-get/fb2-mode")
(require 'fb2-mode)
;;; csv parsing initialize
(require 'parse-csv)
;;; -----------------------------------

(setq auto-mode-alist
      (append
       '(("channels" . erc-channels-mode)
         ("PKGBUILD" . shell-script-mode))
       auto-mode-alist))
;;; -----------------------------------
(defun arch ()
  (if (string-equal "x86_64" (substring (shell-command-to-string "uname -m") 0 -1))
      "amd64" "x86"))

;; (defun deb-package-root-dir ()
;;   (if (string-equal "DEBIAN"
;;                     (file-name-nondirectory
;;                      (directory-file-name default-directory)))
;;       (file-name-directory (directory-file-name default-directory))
;;     (message "You aren't in DEBIAN dir!")))

(defun debian-control-description ()
  (interactive)
  (let* ((data-str (substring default-directory 0 -1))
         (data-list (car (last (butlast (split-string data-str "/")))))
         (dirname  (split-string data-list "_"))
         (pkg-name (car dirname))
         (pkg-version (cadr dirname))
         (pkg-arch (caddr dirname)))
    (insert "Package: " pkg-name "\n"
            "Version: " pkg-version "\n"
            "Architecture: " pkg-arch "\n"
            "Maintainer: " my-name " " my-email "\n"
            "Depends: \n"
            "Priority: optional\n"
            "Description-en: fixme\n")
    (backward-char)))

(defun make-deb-control-description ()
  (interactive)
  (let* ((prjnv ;;; project-and-version
          (split-string
           (file-name-nondirectory (directory-file-name default-directory))
           "-"))
         (debian-dir (concat (car prjnv) "_" (cadr prjnv) "_" (arch) "/DEBIAN")))
    (make-directory debian-dir)
    (generate-new-buffer "control")
    (switch-to-buffer "control")
    (insert "Package: " (car prjnv) "\n"
            "Version: " (cadr prjnv) "\n"
            "Architecture: " (arch) "\n"
            "Maintainer: " my-name " " my-email "\n"
            "Depends: \n"
            "Priority: optional\n"
            "Description-en: fixme\n")
    (backward-char)
    (write-file (concat debian-dir "/control"))))

(defun find-fish-config ()
  (interactive)
  (find-file "~/.config/fish/config.fish"))

;; edit server
(when (and (daemonp) (locate-library "edit-server"))
  (require 'edit-server)
  (edit-server-start))

;; The edit To open pages for editing in a new buffer
;; instead of a new frame on your running Emacs instance do:
;; (when (locate-library "edit-server")
;;   (require 'edit-server)
;;   (setq edit-server-new-frame nil)
;;   (edit-server-start))

(defun fix-macaddr ()
  (interactive)
  (goto-char 1)
  (while (search-forward-regexp "\\([0-9A-Fa-f]\\{2\\}[:-]\\)\\{5\\}\\([0-9A-Fa-f]\\{2\\}\\)" nil t) 
    (replace-match
     (upcase
      (replace-regexp-in-string
       (regexp-quote "-") ":" (match-string 0) nil 'literal))
     nil t)))

(defun indent-buffer ()
  "Indent current buffer according to major mode."
  (interactive)
  (indent-region (point-min) (point-max)))

;; edit file as root, the code was taken from:
;; http://emacsredux.com/blog/2013/04/21/edit-files-as-root/
(defun sudo-edit (&optional arg)
  "Edit currently visited file as root.
   With a prefix ARG prompt for a file to visit.
   Will also prompt for a file to visit if current
   buffer is not visiting a file."
  (interactive "P")
  (if (or arg (not buffer-file-name))
      (find-file (concat "/sudo:root@localhost:"
                         (ido-read-file-name "Find file(as root): ")))
    (find-alternate-file (concat "/sudo:root@localhost:" buffer-file-name))))

;; ispell
;; stolen from: http://pragmaticemacs.com/emacs/basic-spell-checking/
(setq ispell-really-hunspell t)
;; tell ispell that apostrophes are part of words
;; and select Bristish dictionary
(setq ispell-local-dictionary-alist
      `((nil "[[:alpha:]]" "[^[:alpha:]]" "[']" t ("-d" "en_GB") nil utf-8)))

;; wttr.in
(setq wttrin-default-cities '("Novosibirsk"))
(setq wttrin-default-accept-language '("Accept-Language" . "en-GB"))

(provide 'global-cfg)
