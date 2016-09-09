;; Set your lisp system and, optionally, some contribs
(require 'slime-autoloads)
(setq-default inferior-lisp-program (case system-type
                                      ('gnu/linux "/usr/local/bin/sbcl")
                                      ('windows-nt "C:/SBCL/sbcl.exe")))
;;;(setq-default slime-contribs 'slime-fancy)
;;(setq slime-contribs '(slime-scratch slime-editing-commands))
(setq slime-contribs '(slime-fancy))
;;; keybinding for launch SLIME
(define-key slime-mode-map (kbd "C-c <f5>") (lambda ()
                                              (interactive)
                                              (slime-setup)
                                              (slime)))

(provide 'slime-cfg)
