;;; custom variables ;; -*- lexical-binding: t; -*-
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(blink-cursor-mode nil)
 '(browse-url-browser-function 'eww-browse-url)
 '(c-default-style
   '((c-mode . "linux")
     (java-mode . "java")
     (awk-mode . "awk")
     (other . "gnu")))
 '(column-number-mode t)
 '(cursor-type 'bar)
 '(display-time-24hr-format t)
 '(display-time-day-and-date t)
 '(display-time-default-load-average nil)
 '(display-time-interval 10)
 '(display-time-mode t)
 '(doc-view-resolution 96)
 '(eww-bookmarks-directory "~/.emacs.d/eww/bookmarks/")
 '(eww-use-external-browser-for-content-type "\\`\\(video/\\|audio/\\|application/ogg\\)")
 '(flycheck-clang-include-path '("/usr/include/libxml2/" "/usr/include/qt/"))
 '(flycheck-gcc-include-path '("/usr/include/libxml2/"))
 '(flycheck-clang-includes '("/usr/include/libxml2/"))
 '(global-hl-line-mode t)
 '(global-visual-line-mode t)
 '(indent-tabs-mode nil)
 '(inhibit-startup-screen t)
 '(initial-scratch-message nil)
 '(ispell-program-name "hunspell")
 '(line-number-mode t)
 '(linum-format (if window-system 'dynamic "%d "))
 '(magit-log-section-arguments '("--decorate" "-n256"))
 '(markdown-command "multimarkdown")
 '(menu-bar-mode nil)
 '(mouse-wheel-follow-mouse t)
 '(mouse-wheel-mode t)
 '(mouse-wheel-progressive-speed nil)
 '(mouse-wheel-scroll-amount '(1))
 '(mouse-yank-at-point t)
 '(neo-after-create-hook '(hl-line-mode))
 '(neo-autorefresh nil)
 '(neo-theme 'arrow)
 '(org-latex-inputenc-alist '(("utf8" . "utf8x")))
 '(package-selected-packages '(rainbow-mode queue csv-mode))
 '(racket-images-inline t)
 '(racket-program "/usr/bin/racket")
 '(scroll-bar-mode nil)
 '(scroll-conservatively 10000)
 '(scroll-preserve-screen-position t)
 '(select-enable-clipboard t)
 '(show-paren-delay 0)
 '(show-paren-mode t)
 '(solarized-distinct-fringe-background t)
 '(solarized-high-contrast-mode-line t)
 '(switch-to-buffer-preserve-window-point 'already-displayed)
 '(tool-bar-mode nil)
 '(url-user-agent 'curl))

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
 '(rainbow-delimiters-depth-6-face ((t (:foreground "#0060FF"))))
 '(rainbow-delimiters-depth-7-face ((t (:foreground "#9900FF"))))
 '(rainbow-delimiters-depth-8-face ((t (:foreground "#FF00FF"))))
 '(rainbow-delimiters-depth-9-face ((t (:foreground "#FCFCFC")))))

;;; set off disables of up- and downcase fns
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

(provide 'custom-cfg)
