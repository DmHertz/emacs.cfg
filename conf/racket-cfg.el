;; -*- lexical-binding: t; -*-
;; autoload racket-mode when some rkt file is opened
(add-to-list 'auto-mode-alist '("\\.rkt\\'"    . racket-mode))
(add-to-list 'auto-mode-alist '("\\.scrbl\\'"  . racket-mode))
(add-to-list 'auto-mode-alist '("\\.mscrbl\\'" . racket-mode))

;;; custom run racket
;; (add-hook 'racket-mode-hook
;;           (lambda ()
;;             (define-key racket-mode-map (kbd "C-c r") 'racket-run)))

;;; enable unicode
(add-hook 'racket-mode-hook      #'racket-unicode-input-method-enable)
(add-hook 'racket-repl-mode-hook #'racket-unicode-input-method-enable)

;;; -----------------------------------------------------------------


;;; some redefinition
;;; https://github.com/greghendershott/racket-mode/blob/914c73ecd1166c9bc4fa227bb7051c87ade0030b/racket-repl.el
(defun my-racket-send-last-sexp ()
  "Send the previous sexp to the Racket REPL.
When the previous sexp is a sexp comment the sexp itself is sent,
without the #; prefix."
  (interactive)
  (let ((source-buffer (current-buffer)))
    (racket--send-region-to-repl (racket--repl-last-sexp-start)
                                 (point))
    (switch-to-buffer source-buffer)))

;;; Auto completion

;; The usual M-x complete-symbol -- bound by default to C-M-i -- works,
;; drawing on all symbols in the current Racket namespace.
(setq tab-always-indent 'complete)

(add-hook 'racket-mode-hook #'company-mode)

(add-hook 'racket-mode-hook
          (lambda ()
            (define-key racket-mode-map (kbd "C-x C-e") #'my-racket-send-last-sexp)))

;; lambda
(eval-after-load 'racket-mode
  '(progn
     (define-key racket-mode-map (kbd "C-\\") "λ")
     (define-key racket-mode-map (kbd "C-c C-\\") "λ")))

(provide 'racket-cfg)
