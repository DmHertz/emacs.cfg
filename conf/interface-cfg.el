;; ;; Interface setup
;; ;; menu, tool and scroll bars to /dev/null
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

(setq inhibit-splash-screen t) ;; no splash
(line-number-mode 1)

(blink-cursor-mode 0)         ;; no blinking cursor
;; fullscreen
(add-to-list 'default-frame-alist '(fullscreen . fullboth)) 
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

;; ;; Nerd tree
 (require 'neotree)
 (add-hook 'neotree-mode-hook 'hl-line-mode)
;; ;;; limit line length
 (require 'whitespace)
(setq whitespace-line-column 80)
(setq whitespace-style '(face lines-tail))
;; don't show start up screen, message; and define size
(setq-default inhibit-startup-screen t)
(setq initial-scratch-message nil)
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
(set-frame-parameter (selected-frame) 'alpha '(87 80))
(add-to-list 'default-frame-alist '(alpha 87 80))
;;;face font, bg and fg
(cl-defun set-face! (&key (bg-color "#000000")
                          face-font font-height)
  (set-face-background 'fringe bg-color) ;;; l, r borders around frame
  (set-face-attribute 'default nil
                      :background bg-color
                      :font face-font
                      :height font-height))

(defun face-settings ()
  (case system-type
    ('gnu/linux (set-face! :face-font "Terminus"
                           :font-height 120))
    ('windows-nt (set-face! :face-font "Terminus (TTF)"
                            :font-height 120))))

(defun load--theme (frame)
  (select-frame frame)
  (face-settings))

(if (daemonp)
    (add-hook 'after-make-frame-functions #'load--theme)
  (face-settings))

(provide 'interface-cfg)
