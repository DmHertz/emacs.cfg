;; Set your lisp system and, optionally, some contribs
(load (expand-file-name "~/quicklisp/slime-helper.el"))

(setq-default inferior-lisp-program (case system-type
                                      ('gnu/linux "/usr/local/bin/sbcl")
                                      ('windows-nt "C:/SBCL/sbcl.exe")))
(slime-setup '(slime-company))

;; keybinding for launch SLIME
(define-key slime-mode-map (kbd "C-c <f5>") 'slime)

;; (require 'slime-autoloads)
;;(setq-default slime-contribs 'slime-fancy)
;;(setq slime-contribs '(slime-scratch slime-editing-commands))
;;(setq slime-contribs '(slime-fancy slime-company))

(provide 'slime-cfg)
