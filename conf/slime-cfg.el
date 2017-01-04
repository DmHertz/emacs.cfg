;; -*- lexical-binding: t; -*-
;; Set your lisp system and, optionally, some contribs
(load (expand-file-name "~/quicklisp/slime-helper.el"))
;; download slime-company package directly
(let* ((ql-software-base-path "~/quicklisp/dists/quicklisp/software/")
       (ql-slime-dist-path (car (remove-if-not
                                 (lambda (s) (string-match "^slime-" s))
                                 (directory-files ql-software-base-path))))
       (ql-slime-company-contrib-path "/contrib/slime-company.el")
       (ql-slime-company-full-path (concatenate 'string
                                                ql-software-base-path
                                                ql-slime-dist-path
                                                ql-slime-company-contrib-path)))
  (unless (file-exists-p ql-slime-company-full-path)
    (url-copy-file
     "https://raw.githubusercontent.com/anwyn/slime-company/master/slime-company.el"
     ql-slime-company-full-path t)))

(setq slime-lisp-implementations
      (case system-type
        ('gnu/linux
         '((sbcl ("/usr/local/bin/sbcl") :coding-system utf-8-unix)
           (ccl ("~/.bin/ccl/lx86cl64"))))
        ('windows-nt
         '((sbcl ("C:/cl/sbcl/sbcl.exe") :coding-system utf-8)
           (ccl ("C:/cl/ccl/lx86cl64.exe"))))))

(slime-setup '(slime-company))

(define-key company-active-map (kbd "\C-n") 'company-select-next)
(define-key company-active-map (kbd "\C-p") 'company-select-previous)
(define-key company-active-map (kbd "\C-d") 'company-show-doc-buffer)
(define-key company-active-map (kbd "M-.") 'company-show-location)

;; keybinding for launch SLIME
(define-key slime-mode-map (kbd "C-c <f5>") 'slime)

;; (require 'slime-autoloads)
;;(setq-default slime-contribs 'slime-fancy)
;;(setq slime-contribs '(slime-scratch slime-editing-commands))
;;(setq slime-contribs '(slime-fancy slime-company))

(provide 'slime-cfg)
