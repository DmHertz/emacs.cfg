;; -*- lexical-binding: t; -*-
;; ;; hooks
(add-hook 'emacs-lisp-mode-hook #'company-mode)

(define-key emacs-lisp-mode-map (kbd "C-\\") "lambda")
(define-key emacs-lisp-mode-map (kbd "C-c C-\\") "lambda")

(provide 'elisp-cfg)
