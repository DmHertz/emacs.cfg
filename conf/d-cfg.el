;; this config is borrowed from
;; https://www.emacswiki.org/emacs/FlyMakeD
;; and partially modified
(require 'flymake)
(require 'd-mode)
(require 'company-dcd)

(defun flymake-d-init ()
  (let* ((temp-file (flymake-init-create-temp-buffer-copy
                     'flymake-create-temp-inplace))
         (local-file (file-relative-name
                      temp-file
                      (file-name-directory buffer-file-name))))
    (list "dmd" (list "-c" local-file))))

(add-to-list 'flymake-allowed-file-name-masks
             '(".+\\.d$" flymake-D-init 
               flymake-simple-cleanup flymake-get-real-file-name))

(add-to-list 'flymake-err-line-patterns
             '("^\\([^ :]+\\)(\\([0-9]+\\)): \\(.*\\)$" 1 2 nil 3))

(defun flymake-d-load ()
  (flymake-mode t)
  (local-set-key (kbd "C-c C-d") 'flymake-display-err-menu-for-current-line)
  (local-set-key (kbd "C-c C-n") 'flymake-goto-next-error)
  (local-set-key (kbd "C-c C-p") 'flymake-goto-prev-error))


;;; --- d lang ---
(add-hook 'd-mode-hook #'flycheck-dmd-dub-set-variables)
(add-hook 'd-mode-hook #'flymake-d-load)
(add-hook 'd-mode-hook #'company-dcd-mode)

(provide 'd-cfg)
