;; -*- lexical-binding: t; -*-
;;; personal data
(setq my-name  "Dmitry Hertz")
(setq my-email "<dmitryhertz@gmail.com>")
(setq my-page  "http://dmhz.xyz")
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
;;; --- d lang ---
(require 'company-dcd)
(add-hook 'd-mode-hook #'flycheck-dmd-dub-set-variables)
(add-hook 'd-mode-hook #'company-dcd-mode)
;;; -----------------------------------

(setq auto-mode-alist
      (append
       '(("channels" . erc-channels-mode)
         ("PKGBUILD" . shell-script-mode))
       auto-mode-alist))
;;; -----------------------------------
(defun arch ()
  (if (string-equal "x86_64" (substring (shell-command-to-string "arch") 0 -1))
      "amd64" "x86"))

;; (defun deb-package-root-dir ()
;;   (if (string-equal "DEBIAN"
;;                     (file-name-nondirectory
;;                      (directory-file-name default-directory)))
;;       (file-name-directory (directory-file-name default-directory))
;;     (message "You aren't in DEBIAN dir!")))

(defun slurp (fpath)
  (with-temp-buffer
  (insert-file-contents fpath)
  (buffer-string)))

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

(provide 'global-cfg)
