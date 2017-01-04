;; -*- lexical-binding: t; -*-;;
;;(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
;;
(add-hook 'haskell-mode-hook 'turn-on-hi2)
;;
;;(add-hook 'haskell-mode-hook #'hindent-mode)

(add-hook 'haskell-mode-hook 'interactive-haskell-mode)
;; enabling cabal-repl instead ghci 
(custom-set-variables '(haskell-process-type 'cabal-repl))
;;

(provide 'haskell-cfg)
