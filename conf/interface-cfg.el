;; Interface setup ;; -*- lexical-binding: t; -*-

;; set symbol for the border
(set-display-table-slot standard-display-table
                        'vertical-border
                        (make-glyph-code ?│))

;; ;; menu, tool and scroll bars to /dev/null
(seq-doseq (m '(menu tool scroll))
  (funcall (append-sym-postfix m "-bar-mode") -1))

;; no splash
(setq inhibit-splash-screen t)
;; don't show start up screen, message; and define size
(setq inhibit-startup-screen t)
(setq initial-scratch-message nil)
(line-number-mode 1)
;; no blinking cursor
(blink-cursor-mode 0)
(setq-default cursor-type 'bar)
;; (set-cursor-color "#ffff00")

(setq scroll-preserve-screen-position t)
(setq switch-to-buffer-preserve-window-point t)

;; fullscreen
;; (add-to-list 'default-frame-alist '(fullscreen . fullboth)) ;; broken in 25.1 --with-cairo
;; ;; Mode bar preferences
(column-number-mode 1)            ; show column number in mode-line
(setq display-time-day-and-date t ; display the day and date in the mode line
      display-time-24hr-format t  ; use 24hr format
      display-time-interval 10    ; redisplay every ten seconds
      display-time-default-load-average nil) ; don't display the system load average

(display-time)

;; ;; Enable mouse wheel
(mouse-wheel-mode 1)
(setq mouse-wheel-scroll-amount '(1) ; mouse scroll one line at a time
      mouse-wheel-progressive-speed nil ; don't accelerate scrolling
      mouse-wheel-follow-mouse t        ; scroll window under mouse
      scroll-conservatively 10000) ; scroll one line at a time if point moves off-screen

(setq x-select-enable-clipboard t   ; cut and paste to the X clipboard
      mouse-yank-at-point t)        ; paste at point NOT at cursor

;; highlight line
(add-hook 'neotree-mode-hook 'hl-line-mode)
;; ;;; limit line length ;; doesn't work
;; (require 'whitespace)
;; (setq whitespace-line-column 80)
;; (setq whitespace-style '(face lines-tail))

;; Disable r-t-l (arabic, jewish, etc)
(setq-default bidi-display-reordering nil)
;; scroll auto

;; Instead «yes» or «no» will be «y» or «n»
(fset 'yes-or-no-p 'y-or-n-p)
;; Always show column numbers
(setq-default column-number-mode t)

;; Display full pathname for files
(add-hook 'find-file-hooks
          '(lambda ()
             (setq mode-line-buffer-identification 'buffer-file-truename)))
;;(setq transient-mark-mode 1)
;; 
(font-lock-mode -1)
;; Spaces only, without tab chars
(setq-default indent-tabs-mode nil)

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
;;; ┌──────────────────────────────────┐
;;; │          color settings          │
;;; └──────────────────────────────────┘
;;; Solarized colorscheme
;;; make the fringe stand out from the background
(setq solarized-distinct-fringe-background t)
;;; make the modeline high contrast
(setq solarized-high-contrast-mode-line t)
;;; Use more italics
;;;(setq solarized-use-more-italic t)
;;; Use less colors for indicators such as git:gutter, flycheck and similar.
;;;(setq solarized-emphasize-indicators nil)

(require 'solarized)
(deftheme solarized-dark
  "The dark variant of the Solarized color theme")
(create-solarized-theme 'dark 'solarized-dark)
(provide-theme 'solarized-dark)

;; transparency '(alpha `active `inactive)
(let ((active 90)
      (inactive 80))
  (set-frame-parameter (selected-frame) 'alpha (list active inactive))
  (add-to-list 'default-frame-alist (list 'alpha active inactive)))
;;;face font, bg and fg
(setq bg-color "#000000"
      face-font-height 80
      face-font-step 10
      face-fonts '("xos4 Terminus" "Terminus (TTF)"
                   "Monospace" "Liberation Mono"
                   "DejaVu Sans Mono" "Inconsolata")
      default-face-font (case system-type
                          ('gnu/linux  (car  face-fonts))
                          ('windows-nt (cadr face-fonts))))

(defun choose-font (fontname)
  (interactive
   (list
    (completing-read "Choose font: " face-fonts)))
  (set-face-attribute 'default nil :font fontname)) 

(defun apply-font-height (fn)
  (setq face-font-height
        (mod (funcall fn face-font-height face-font-step) 360)))

(defun set-font-height (num)
  (interactive "nEnter height: ")
  (setq face-font-height num)
  (set-face-attribute 'default nil :height num))

(defun check-font-height ()
  "lets to know current height of the font which is using now"
  (interactive)
  (message (concat "Font height is " (number-to-string face-font-height))))

(defun -font-height ()
  (interactive)
  (apply-font-height #'-)
  (set-face-attribute 'default nil :height face-font-height))

(defun +font-height ()
  (interactive)
  (apply-font-height #'+)
  (set-face-attribute 'default nil :height face-font-height))

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
                            :height face-font-height)))

(provide 'interface-cfg)
