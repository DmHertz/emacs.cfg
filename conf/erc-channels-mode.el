
;; a simple major mode, erc-channels-mode

(setq erc-channels-highlights
      '((";[\#\-\;\sa-z]+" . font-lock-comment-face)
        ("[a-z0-9-]+\\.[a-z0-9\\.]+\\s-" . font-lock-keyword-face)
;;;        ("#[#a-z0-9]+[#\-_]+" . font-lock-warning-face)
        ("#\\{1,2\\}[a-z0-9-]+" .
         font-lock-variable-name-face)))

(define-derived-mode erc-channels-mode fundamental-mode "erc-channels"
  "major mode for editing erc-channels markup."
;;;  (setq-local comment-start ";; ")
  (setq-local font-lock-defaults '(erc-channels-highlights)))

(provide 'erc-channels-mode)
