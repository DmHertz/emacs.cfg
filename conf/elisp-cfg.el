;; ;; hooks
;; (add-hook 'emacs-lisp-mode-hook (lambda ()
;;         ;; highlight parenthes as rainbow 
;;            (rainbow-delimiters-mode)
;;         ;; highlight color sets, hex (anywhere) and rgb (if html/css)
;;            (rainbow-mode)))

(add-hook 'emacs-lisp-mode-hook #'company-mode)

(provide 'elisp-cfg)
