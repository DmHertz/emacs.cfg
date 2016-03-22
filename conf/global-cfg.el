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
;;;
(defun debian-control-description ()
  (interactive)
  (let* ((data-str (substring
                  (shell-command-to-string "pwd")
                  0 -1))
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

(defun find-fish-config ()
  (interactive)
  (find-file "~/.config/fish/config.fish"))
