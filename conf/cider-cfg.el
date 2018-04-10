;; Cider Preferences ;; -*- lexical-binding: t; -*-
(require 'icomplete)
;; enable eldoc
(add-hook 'cider-mode-hook #'eldoc-mode)
(add-hook 'cider-mode-hook #'company-mode)
(add-hook 'cider-repl-mode-hook #'company-mode)
;; Suppress auto-enabling of cider-mode in clojure-mode buffers,
;; when starting CIDER:
;;(setq cider-auto-mode nil)
;; Log communication with the nREPL server (extremely useful
;; for debugging CIDER problems):
;(setq nrepl-log-messages t)
;; You can hide the *nrepl-connection* and *nrepl-server* buffers
;; from appearing in some buffer switching commands like
;; switch-to-buffer(C-x b) like this:
(setq nrepl-hide-special-buffers t)
;; To prefer local resources to remote (tramp) ones when both are available:
(setq cider-prefer-local-resources t)
;; You can control the TAB key behavior in the REPL via the
;; cider-repl-tab-command variable. While the default command
;; cider-repl-indent-and-complete-symbol should be an adequate
;; choice for most users, it's very easy to switch to another
;; command if you wish to. For instance if you'd like TAB to
;; only indent (maybe because you're used to completing with M-TAB)
;; use the following snippet:
(setq cider-repl-tab-command #'indent-for-tab-command)
;; Prevent the auto-display of the REPL buffer in a separate window
;; after connection is established:
(setq cider-repl-pop-to-buffer-on-connect nil)
;;;Configure whether the error buffer with stacktraces should be automatically shown on error:
;;;Don't show on error:
(setq cider-show-error-buffer nil)
;; If using the wrap-stacktrace middleware from cider-nrepl,
;; error buffer stacktraces may be filtered by default.
;; Valid filter types include java, clj, repl, tooling, and dup.
;; Setting this to nil will show all stacktrace frames.
(setq cider-stacktrace-default-filters '(tooling dup))
(setq cider-stacktrace-fill-column 80)
;; Show error
;;(setq cider-show-error-buffer nil)
;; More info when error is appears
;;;(setq debug-on-error t)
;; Select strategy
;; (setq cider-show-error-buffer 'except-in-repl)
(setq cider-show-error-buffer 'only-in-repl)
;; To disable auto-selection of the error buffer when it's displayed:
;;(setq cider-auto-select-error-buffer nil)
;;
(setq nrepl-buffer-name-separator "-")
;;
(setq nrepl-buffer-name-show-port t)
;; hange the result prefix for REPL evaluation (by default there's no prefix):
(setq cider-repl-result-prefix ";; ~> ")
;; Make C-c C-z switch to the CIDER REPL buffer in the current window
(setq cider-repl-display-in-current-window t)
;; You can control the C-c C-z key behavior of switching to the REPL buffer
;; with the cider-switch-to-repl-command variable. While the default command
;; cider-switch-to-relevant-repl-buffer should be an adequate choice
;; for most users, cider-switch-to-current-repl-buffer offers a simpler
;; alternative where CIDER will not attempt to match the correct
;; REPL buffer based on underlying project directories:
(setq cider-switch-to-repl-command #'cider-switch-to-current-repl-buffer)
;;
(setq cider-repl-use-pretty-printing nil)
;; You can configure known endpoints used by the cider command offered
;; via a completing read. This is useful if you have a list of common
;; host/ports you want to establish remote nREPL connections to.
;; Using an optional label is helpful for identifying each host.
(setq cider-known-endpoints '(("host-a" "127.0.0.1" "7888") ("host-b" "7888")))

;;; REPL history
(setq cider-repl-wrap-history t)
(setq cider-repl-history-size 1000) ; the default is 500
(setq cider-repl-history-file "~/.emacs.d/cider-repl-history")


;;

(setq cider-prompt-save-file-on-load nil)
(setq cider-auto-select-error-buffer t)
(setq cider-repl-pop-to-buffer-on-connect nil)
(setq cider-repl-tab-command #'indent-for-tab-command)
;;
(setq cider-cljs-lein-repl "(do (use 'figwheel-sidecar.repl-api) 
                                (start-figwheel!) 
                                (cljs-repl))")

;; lambda
(eval-after-load 'cider
  '(progn
     (define-key cider-mode-map (kbd "C-\\") "fn")
     (define-key cider-mode-map (kbd "C-c C-\\") "fn")))

(provide 'cider-cfg)
