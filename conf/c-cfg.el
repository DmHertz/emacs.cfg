(add-hook 'c++-mode-hook #'irony-mode)
(add-hook 'c-mode-hook #'irony-mode)
;; (add-hook 'objc-mode-hook #'irony-mode)

;; replace the `completion-at-point' and `complete-symbol' bindings in
;; irony-mode's buffers by irony-mode's function
(defun my-irony-mode-hook ()
  (define-key irony-mode-map [remap completion-at-point]
    #'irony-completion-at-point-async)
  (define-key irony-mode-map [remap complete-symbol]
    #'irony-completion-at-point-async))
(add-hook 'irony-mode-hook #'my-irony-mode-hook)
(add-hook 'irony-mode-hook #'irony-cdb-autosetup-compile-options)
(add-hook 'irony-mode-hook #'eldoc-mode)

(eval-after-load 'company
  '(add-to-list 'company-backends #'company-irony))

(eval-after-load 'flycheck
  '(add-hook 'flycheck-mode-hook #'flycheck-irony-setup))

(add-hook 'irony-mode-hook #'company-mode)
(add-hook 'irony-mode-hook #'flycheck-mode)

(provide 'c-cfg)