;; Set smartparens config
(require 'smartparens)

(defun add-parens-hooks (lst)
  (when lst
    (add-hook (-> lst car symbol-name (concat "-mode-hook") intern)
              (lambda ()
                (show-smartparens-mode 1)
                (smartparens-strict-mode 1)
                (rainbow-mode 1)
                (rainbow-delimiters-mode 1)))
    (add-parens-hooks (cdr lst))))

(eval-after-load
    'smartparens
  '(progn
     (add-parens-hooks
      '(lisp common-lisp slime-repl emacs-lisp ielm racket racket-repl clojure cider-repl
             css html 
             eshell gimp markdown))
     ;;; customize
     (sp-pair "(" ")"   :wrap "C-)")
     (sp-pair "[" "]"   :wrap "C-]")
     (sp-pair "\"" "\"" :wrap "C-\"")
;;;     (sp-pair "{" nil :actions :rem)
     (sp-pair "'" nil :actions :rem)
     (sp-pair "`" nil :actions :rem)

     ;; adds `' as a local pair in emacs-lisp-mode
     (sp-local-pair 'emacs-lisp-mode "`" "'")))
