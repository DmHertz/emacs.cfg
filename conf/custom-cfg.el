;;; custom variables ;; -*- lexical-binding: t; -*-
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(blink-cursor-mode nil)
 '(browse-url-browser-function (quote eww-browse-url))
 '(c-default-style
   (quote
    ((c-mode . "linux")
     (java-mode . "java")
     (awk-mode . "awk")
     (other . "gnu"))))
 '(cider-cljs-lein-repl
   "(do (require 'weasel.repl.websocket) 
    (cemerick.piggieback/cljs-repl
      (weasel.repl.websocket/repl-env :ip \"127.0.0.1\" :port 9001)))" t)
 '(column-number-mode t)
 '(cursor-type (quote bar))
 '(dired-async-mode t)
 '(display-time-24hr-format t)
 '(display-time-day-and-date t)
 '(display-time-default-load-average nil)
 '(display-time-interval 10)
 '(display-time-mode t)
 '(doc-view-resolution 96)
 '(eww-bookmarks-directory "~/.emacs.d/eww/bookmarks/")
 '(eww-use-external-browser-for-content-type "\\`\\(video/\\|audio/\\|application/ogg\\)")
 '(global-visual-line-mode t)
 '(indent-tabs-mode nil)
 '(inhibit-startup-screen t)
 '(initial-scratch-message nil)
 '(line-number-mode t)
 '(linum-format (if window-system (quote dynamic) "%d "))
 '(markdown-command "multimarkdown")
 '(menu-bar-mode nil)
 '(mouse-wheel-follow-mouse t)
 '(mouse-wheel-mode t)
 '(mouse-wheel-progressive-speed nil)
 '(mouse-wheel-scroll-amount (quote (1)))
 '(mouse-yank-at-point t)
 '(neo-after-create-hook (quote (hl-line-mode)))
 '(neo-autorefresh nil)
 '(neo-theme (quote arrow))
 '(package-selected-packages (quote (csv-mode rainbow-mode queue finalize)))
 '(racket-images-inline t)
 '(scroll-bar-mode nil)
 '(scroll-conservatively 10000)
 '(scroll-preserve-screen-position t)
 '(select-enable-clipboard t)
 '(solarized-distinct-fringe-background t)
 '(solarized-high-contrast-mode-line t)
 '(switch-to-buffer-preserve-window-point (quote already-displayed))
 '(tool-bar-mode nil))

;;; +---------------------------------------------------------------+
;;; |            custom faces                                       |
;;; +---------------------------------------------------------------+
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(font-lock-comment-delimiter-face ((t (:foreground "#222222" :slant normal))))
 '(linum ((t (:background "#000000" :foreground "#003366"))))
 '(neo-banner-face ((t (:foreground "#f86e75"))))
 '(rainbow-delimiters-depth-1-face ((t (:foreground "#FF0000"))))
 '(rainbow-delimiters-depth-2-face ((t (:foreground "#FF8000"))))
 '(rainbow-delimiters-depth-3-face ((t (:foreground "#FFFF00"))))
 '(rainbow-delimiters-depth-4-face ((t (:foreground "#00FF00"))))
 '(rainbow-delimiters-depth-5-face ((t (:foreground "#00FFFF"))))
 '(rainbow-delimiters-depth-6-face ((t (:foreground "#0080FF"))))
 '(rainbow-delimiters-depth-7-face ((t (:foreground "#0000FF"))))
 '(rainbow-delimiters-depth-8-face ((t (:foreground "#9900FF"))))
 '(rainbow-delimiters-depth-9-face ((t (:foreground "#FF00FF")))))

;;; set off disables of up- and downcase fns
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

(provide 'custom-cfg)
