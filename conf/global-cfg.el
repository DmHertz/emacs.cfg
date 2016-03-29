;;; personal data
(setq my-name  "Dmitry Hertz")
(setq my-email "<dmitryhertz@gmail.com>")
(setq my-page  "http://dmhz.xyz")

;; encoding
(prefer-coding-system 'utf-8)
(setq file-name-coding-system 'utf-8)
;;; globals
(global-company-mode)
(load-file "~/.emacs.d/company-statistics-cache.el")
;;; global hooks
(add-hook 'after-init-hook #'company-statistics-mode)
;;; archiver, needs for 'windows-nt
(when (eq 'windows-nt system-type)
  (add-to-list 'exec-path "C:/Program Files/7-Zip"))
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
            "Description: fixme")))

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
            "Description: fixme\n")
    (backward-char)
    (write-file (concat debian-dir "/control"))))

(defun find-fish-config ()
  (interactive)
  (find-file "~/.config/fish/config.fish"))


