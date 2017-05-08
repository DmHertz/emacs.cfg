;; Interface setup ;; -*- lexical-binding: t; -*-

(setq ;; interface settings
 ;; disable useless garbage
 inhibit-splash-screen t     ;; no start up splash
 inhibit-startup-screen t    ;; screen
 initial-scratch-message nil ;; and message
 ;; mode-line
 line-number-mode t          ;; line number in mode-line
 column-number-mode t        ;; column number
 display-time-day-and-date t ;; display the day and date in the mode line
 display-time-24hr-format t  ;; use 24hr format
 display-time-interval 10    ;; redisplay every ten seconds
 display-time-default-load-average nil ;; don't display the system load average
 ;;  screen, window, buffer
 scroll-preserve-screen-position t
 switch-to-buffer-preserve-window-point t
  ;; x
 x-select-enable-clipboard t   ;; cut and paste to the X clipboard
 ;; mouse
 mouse-yank-at-point t         ;; paste at point NOT at cursor
 mouse-wheel-mode t
 mouse-wheel-scroll-amount '(1)    ;; mouse scroll one line at a time
 mouse-wheel-progressive-speed nil ;; don't accelerate scrolling
 mouse-wheel-follow-mouse t        ;; scroll window under mouse
 scroll-conservatively 10000 ;; scroll one line at a time if point moves off-screen
 ;; cursor
 blink-cursor-mode nil
 cursor-type 'bar
 ;; font, script
 font-lock-mode nil
 indent-tabs-mode nil        ;; spaces only, without tab chars
 bidi-display-reordering nil ;; disable r-t-l (arabic, jewish, etc)
 ;; Solarized colorscheme
 solarized-distinct-fringe-background t     ;; make the fringe stand out from the bg
 solarized-high-contrast-mode-line t        ;; make the modeline high contrast
 ;; setq solarized-use-more-italic t        ;; use more italics
 ;; setq solarized-emphasize-indicators nil ;; use less colors for indicators such
                                            ;; as git:gutter, flycheck and similar.
 ;; face font, bg and fg
 bg-color "#000000"
 face-font-height 80
 face-font-step 10
 face-fonts '("Terminus" "xos4 Terminus" "Terminus (TTF)"
              "Monospace" "Liberation Mono"
              "DejaVu Sans Mono" "Inconsolata")
 default-face-font (case distro
                     ('arch       (cadr  face-fonts))
                     ('ubuntu     (car   face-fonts))
                     ('windows-nt (caddr face-fonts))))
;; turn on Solarized theme
(require 'solarized)
(deftheme solarized-dark
  "The dark variant of the Solarized color theme")
(create-solarized-theme 'dark 'solarized-dark)
(provide-theme 'solarized-dark)

;; monochrome? seriously? ;; was taken from: Phil Hagelberg / dotfiles
(eval-after-load 'diff-mode
  '(progn
     (set-face-foreground 'diff-added "green4")
     (set-face-foreground 'diff-removed "red3")))
;; (eval-after-load 'magit
;;   '(progn
;;      (set-face-background 'magit-item-highlight "white smoke")
;;      (set-face-foreground 'magit-diff-add "green4")
;;      (set-face-foreground 'magit-diff-del "red3")))

;; transparency '(alpha `active `inactive)
(let ((active 90)
      (inactive 80))
  (set-frame-parameter (selected-frame) 'alpha (list active inactive))
  (add-to-list 'default-frame-alist (list 'alpha active inactive)))

;; set symbol for the border
(set-display-table-slot standard-display-table
                        'vertical-border
                        (make-glyph-code ?│))

;; (add-to-list 'default-frame-alist      ;; fullscreen
;;              '(fullscreen . fullboth)) ;; broken in 25.1 --with-cairo

;; Display full pathname for files
(add-hook 'find-file-hooks
          '(lambda ()
             (setq mode-line-buffer-identification 'buffer-file-truename)))

(display-time)
;; instead «yes» or «no» will be «y» or «n»
(fset 'yes-or-no-p 'y-or-n-p)

;; neotree
(add-hook 'neotree-mode-hook 'hl-line-mode) ;; highlight line

(defun choose-font (fontname)
  (interactive
   (list
    (completing-read "Choose font: " face-fonts)))
  (set-face-attribute 'default nil :font fontname)) 

(defmacro set-default-face (body)
  `(if (daemonp)
       (add-hook 'after-make-frame-functions
                 (lambda (frame)
                   (select-frame frame)
                   ,body))
     ,body))

(set-default-face
 (progn (set-face-background 'fringe bg-color) ;;; l, r borders around frame
        (set-face-attribute 'default nil
                            :background bg-color
                            :font default-face-font
                            :height (if (and window-system
                                             (<= (display-pixel-height) 768))
                                        80 100))))

(provide 'interface-cfg)
