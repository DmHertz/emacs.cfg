;; ;; Interface setup

;; set symbol for the border
(set-display-table-slot standard-display-table
                        'vertical-border
                        (make-glyph-code ?│))

;; ;; menu, tool and scroll bars to /dev/null
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

;; no splash
(setq inhibit-splash-screen t)
;; don't show start up screen, message; and define size
(setq inhibit-startup-screen t)
(setq initial-scratch-message nil)
(line-number-mode 1)
 ;; no blinking cursor
(blink-cursor-mode 0)
(setq cursor-type 'bar)
;; (set-cursor-color "#ffff00")
;; fullscreen
(add-to-list 'default-frame-alist '(fullscreen . fullboth)) ;; broken in 25.1 --with-cairo
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

;; ;; after init

;; ;; highlight line
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
(cl-defun set-face! (&key (bg-color "#000000")
                          (font-height 120)
                          face-font)
  (set-face-background 'fringe bg-color) ;;; l, r borders around frame
  (set-face-attribute 'default nil
                      :background bg-color
                      :font face-font
                      :height font-height))

(setq face-font-height 120
      face-font-step 10
      face-fonts '("Terminus" "Terminus (TTF)"
                   "Monospace" "Liberation Mono"
                   "DejaVu Sans Mono"))

(defun choose-font (fontname)
  (interactive
   (list
    (completing-read "Choose font: " face-fonts)))
  (set-face! :face-font fontname))

(defun set-face-settings ()
  (case system-type
    ('gnu/linux (set-face! :face-font (car face-fonts)))
    ('windows-nt (set-face! :face-font (cadr face-fonts)))))

(defun apply-font-height (fn)
  (setq face-font-height
        (mod (funcall fn face-font-height face-font-step) 360)))

(defun set-font-height (num)
  (interactive "nEnter height: ")
  (setq face-font-height num)
  (set-face-settings))

(defun -font-height ()
  (interactive)
  (apply-font-height #'-)
  (set-face-settings))

(defun +font-height ()
  (interactive)
  (apply-font-height #'+)
  (set-face-settings))

(if (daemonp)
    (add-hook 'after-make-frame-functions
              (lambda (frame)
                (select-frame frame)
                (set-face-settings)))
  (set-face-settings))

(provide 'interface-cfg)
