;; -*- lexical-binding: t; -*-
(setq eshell-prompt-function
  (lambda nil
    (concat
     (user-login-name) "@"
     (car (split-string (system-name) "\\."))
     ":" (eshell/pwd) "\n->> ")))

(provide 'eshell-cfg)
