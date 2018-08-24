;; -*- lexical-binding: t; -*-
;; smartparens stuff
;; Set smartparens config
(require 'smartparens-config)
;; pmode 1: smartparens
;; pmode 2: parinfer
;; cmode 1: rainbow-delimiters
;; cmode 2: highlight-parentheses
(defun add-parens-hooks (pmode cmode lst)
  (cond ((null lst)
         (message "parens hooks are done"))
        ((consp lst)
         (let ((mode-name (symbol-name (car lst))))
           (add-hook (intern (concat mode-name "-mode-hook"))
                     (lambda ()
                       (case pmode
                         (1 (progn
                              (show-smartparens-mode 1)
                              (smartparens-strict-mode 1)))
                         (2 (parinfer-mode)))

                       (case cmode
                         (1 (rainbow-delimiters-mode))
                         (2 (highlight-parentheses-mode)))))

           (message (format "%s is done" mode-name))
           (add-parens-hooks pmode cmode (cdr lst))))))

(setq parinfer-extensions
      '(defaults       ;; should be included.
         pretty-parens ;; different paren styles for different modes.
         ;; evil
         ;; lispy
         paredit       ;; Introduce some paredit commands.
         smart-tab     ;; C-b & C-f jump positions and smart shift with tab & S-tab.
         smart-yank))  ;; Yank behavior depend on mode.

(eval-after-load
    'smartparens-config
  '(progn
     ;; customize
     (sp-pair "(" ")"   :wrap "C-)")
     (sp-pair "[" "]"   :wrap "C-]")
     (sp-pair "\"" "\"" :wrap "C-\"")
     ;;(sp-pair "{" nil :actions :rem)
     ;;(sp-pair "'" nil :actions :rem)
     ;;(sp-pair "`" nil :actions :rem)

     ;; adds `' as a local pair in emacs-lisp-mode
     (sp-local-pair 'emacs-lisp-mode "`" "'" :trigger "`")
     (sp-with-modes '(racket-mode racket-repl-mode scheme-mode lisp-mode emacs-lisp-mode)
       (sp-local-pair "#|" "|#" :trigger "\\#|"))))

(add-parens-hooks 1 1 '(lisp common-lisp slime-repl emacs-lisp ielm))
(add-parens-hooks 1 1 '(scheme racket geiser-repl racket-repl clojure cider-repl))
(add-parens-hooks 1 1 '(css html rust c d lua js eshell gimp markdown conf))

(provide 'parens-cfg)
 
