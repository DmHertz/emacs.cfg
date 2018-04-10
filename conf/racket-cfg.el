;; -*- lexical-binding: t; -*-
;; autoload racket-mode when some rkt file is opened
(add-to-list 'auto-mode-alist '("\\.rkt\\'" . racket-mode))
;;; custom run racket
;; (add-hook 'racket-mode-hook
;;           (lambda ()
;;             (define-key racket-mode-map (kbd "C-c r") 'racket-run)))

;;; enable unicode
(add-hook 'racket-mode-hook      #'racket-unicode-input-method-enable)
(add-hook 'racket-repl-mode-hook #'racket-unicode-input-method-enable)

;;; -----------------------------------------------------------------

;;; Auto completion

;; The usual M-x complete-symbol -- bound by default to C-M-i -- works,
;; drawing on all symbols in the current Racket namespace.
(setq tab-always-indent 'complete)

(add-hook 'racket-mode-hook #'company-mode)

;; lambda
(eval-after-load 'racket-mode
  '(progn
     (define-key racket-mode-map (kbd "C-\\") "λ")
     (define-key racket-mode-map (kbd "C-c C-\\") "λ")))

(provide 'racket-cfg)
