;; -*- lexical-binding: t; -*-
;; enable cargo-minor-mode by default in rust-mode
(add-hook 'rust-mode-hook 'cargo-minor-mode)

;; rust sources formatting hook
(add-hook 'rust-mode-hook
          (lambda ()
            (local-set-key (kbd "C-c <tab>") #'rust-format-buffer)))

;; rust autocompletion
(setq racer-cmd "~/.cargo/bin/racer") ;; Rustup binaries PATH
(setq racer-rust-src-path "~/src/rust/src") ;; Rust source code PATH
(setq company-tooltip-align-annotations t)

(add-hook 'rust-mode-hook #'racer-mode)
(add-hook 'racer-mode-hook #'eldoc-mode)
(add-hook 'racer-mode-hook #'company-mode)

;; rust fly syntax checking
(add-hook 'flycheck-mode-hook #'flycheck-rust-setup)
(add-hook 'rust-mode-hook #'flycheck-mode)

(provide 'rust-cfg)
