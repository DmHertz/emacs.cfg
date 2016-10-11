;;; custom variables
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
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
 '(company-auto-complete (quote (quote company-explicit-action-p)))
 '(company-auto-complete-chars (quote (32 95 41 46)))
 '(company-backends
   (quote
    (company-lua company-elisp company-css company-cmake company-keywords company-clang company-files)))
 '(doc-view-resolution 96)
 '(eww-bookmarks-directory "~/.emacs.d/eww/bookmarks/")
 '(eww-use-external-browser-for-content-type "\\`\\(video/\\|audio/\\|application/ogg\\)")
 '(global-company-mode t)
 '(markdown-command "multimarkdown")
 '(neo-theme (quote arrow))
 '(racket-images-inline t))

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
 '(rainbow-delimiters-depth-1-face ((t (:foreground "#FF4C00"))))
 '(rainbow-delimiters-depth-2-face ((t (:foreground "#FFFF00"))))
 '(rainbow-delimiters-depth-3-face ((t (:foreground "#FF0000"))))
 '(rainbow-delimiters-depth-4-face ((t (:foreground "#00FF00"))))
 '(rainbow-delimiters-depth-5-face ((t (:foreground "#EEEEEE"))))
 '(rainbow-delimiters-depth-6-face ((t (:foreground "#0066FF"))))
 '(rainbow-delimiters-depth-7-face ((t (:foreground "#9900FF"))))
 '(rainbow-delimiters-depth-8-face ((t (:foreground "#00FFFF"))))
 '(rainbow-delimiters-depth-9-face ((t (:foreground "#00CC33")))))

;;; set off disables of up- and downcase fns
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

(provide 'custom-cfg)
