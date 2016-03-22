;; Clojure mode
(require 'clojure-mode)
(require 'clojure-mode-extra-font-locking)
;;
(add-hook 'clojure-mode-hook #'subword-mode)
;;
;;
(add-hook 'clojure-mode-hook (lambda ()
                               (define-clojure-indent
                                 (defroutes 'defun)
                                 (GET 2)
                                 (POST 2)
                                 (PUT 2)
                                 (DELETE 2)
                                 (HEAD 2)
                                 (ANY 2)
                                 (context 2))))

;;(add-hook 'clojure-mode-hook #'parinfer-mode)
;; My own clojure interface
;; if need small mode
(defun mymod-clojureiface-small ()
  "Compact interface for dev with Clojure"
  (interactive)


  (split-window-right 88) ;; HH!
  (sticky-window-keep-window-visible)
  (windmove-right)
  (split-window-below 18) ;; AH!
  (switch-to-buffer "*scra")
  (windmove-down)
  (set-buffer "Messages")
  (windmove-left))
