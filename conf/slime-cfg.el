;; -*- lexical-binding: t; -*-
;; Set your lisp system and, optionally, some contribs
(load (expand-file-name "~/quicklisp/slime-helper.el"))
;; download slime-company package directly
(setq-local ql-software-base-path
            (expand-file-name "~/quicklisp/dists/quicklisp/software/"))
(setq-local ql-slime-dist-path
            (car (sort
                  (remove-if-not
                   (lambda (s) (string-match "^slime-" s))
                   (directory-files ql-software-base-path))
                  'string-greaterp)))
(setq-local ql-slime-company-full-path
            (concatenate 'string
                         ql-software-base-path
                         ql-slime-dist-path
                         "/contrib/slime-company.el"))
;; download slome-company.el if it doesn't exist in the newest slime-*.* path
(unless (file-exists-p ql-slime-company-full-path)
  (url-copy-file
   "https://raw.githubusercontent.com/anwyn/slime-company/master/slime-company.el"
   ql-slime-company-full-path t))

(setq slime-lisp-implementations
      (systype-switch
       '((sbcl ("/usr/bin/sbcl") :coding-system utf-8-unix)
         (ccl ("~/.bin/ccl/lx86cl64")))
       '((sbcl ("C:/cl/sbcl/sbcl.exe") :coding-system utf-8)
         (ccl ("C:/cl/ccl/lx86cl64.exe")))
       '((sbcl ("/usr/local/bin/sbcl") :coding-system utf-8-unix))))

(slime-setup '(slime-company))

(define-key company-active-map (kbd "\C-n") 'company-select-next)
(define-key company-active-map (kbd "\C-p") 'company-select-previous)
(define-key company-active-map (kbd "\C-d") 'company-show-doc-buffer)
(define-key company-active-map (kbd "M-.") 'company-show-location)

;; keybinding for launch SLIME
(define-key slime-mode-map (kbd "C-c <f5>") 'slime)

;; lambda
(define-key slime-mode-map (kbd "C-\\") "lambda")
(define-key slime-mode-map (kbd "C-c C-\\") "lambda")

;; (require 'slime-autoloads)
;;(setq-default slime-contribs 'slime-fancy)
;;(setq slime-contribs '(slime-scratch slime-editing-commands))
;;(setq slime-contribs '(slime-fancy slime-company))

(provide 'slime-cfg)
