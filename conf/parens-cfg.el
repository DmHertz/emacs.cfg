;; -*- lexical-binding: t; -*-
(defun add-parens-hooks (lst)
  (cond ((null lst)
         (message "parens hooks are done"))
        ((consp lst)
         (let ((mode-name (symbol-name (car lst))))
           (add-hook (intern (concat mode-name "-mode-hook"))
                     (lambda ()
                       ;; (show-smartparens-mode 1)
                       ;; (smartparens-strict-mode 1)
                       (parinfer-mode)
                       ;; (highlight-parentheses-mode)
                       (rainbow-delimiters-mode)))

           (message (format "%s is done" mode-name))
           (add-parens-hooks (cdr lst))))))

(setq parinfer-extensions
      '(defaults       ;; should be included.
         pretty-parens ;; different paren styles for different modes.
         ;; evil
         ;; lispy
         paredit       ;; Introduce some paredit commands.
         smart-tab     ;; C-b & C-f jump positions and smart shift with tab & S-tab.
         smart-yank))  ;; Yank behavior depend on mode.

(add-parens-hooks '(lisp common-lisp slime-repl emacs-lisp ielm))
(add-parens-hooks '(scheme racket geiser-repl racket-repl clojure cider-repl))
(add-parens-hooks '(css html rust c d lua js eshell gimp markdown conf))

;; smartparens stuff
;; ;; Set smartparens config
;; (require 'smartparens-config)

;; (eval-after-load
;;     'smartparens-config
;;   '(progn
;;      (add-parens-hooks
;;       '(lisp common-lisp slime-repl emacs-lisp ielm
;;              scheme racket geiser-repl racket-repl clojure cider-repl
;;              css html rust c d lua js
;;              eshell gimp markdown conf))
;;      ;;; customize
;;      (sp-pair "(" ")"   :wrap "C-)")
;;      (sp-pair "[" "]"   :wrap "C-]")
;;      (sp-pair "\"" "\"" :wrap "C-\"")
;; ;;;     (sp-pair "{" nil :actions :rem)
;;      (sp-pair "'" nil :actions :rem)
;;      (sp-pair "`" nil :actions :rem)
;;
;;      ;; adds `' as a local pair in emacs-lisp-mode
;;      (sp-local-pair 'emacs-lisp-mode "`" "'")
;;
;;      (sp-with-modes '(racket-mode racket-repl-mode scheme-mode lisp-mode)
;;        (sp-local-pair "#|" "|#" :trigger "\\#|"))))


(provide 'parens-cfg)
