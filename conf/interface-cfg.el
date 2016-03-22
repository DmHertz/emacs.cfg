;; Interface setup
;; menu, tool and scroll bars to /dev/null
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

(setq inhibit-splash-screen t) ;; no splash
(line-number-mode 1)
(column-number-mode 1)
;; after init

;; Nerd tree
(require 'neotree)
(add-hook 'neotree-mode-hook 'hl-line-mode)
;;; limit line length
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
;;; face font, bg and fg
(cl-defun set-face! (&key (bg-color "#000000")
                          face-font font-height)
  (set-face-background 'fringe bg-color) ;;; l, r borders around frame
  (set-face-attribute 'default nil
                      :background bg-color
                      :font face-font
                      :height font-height))

(case system-type
  ('gnu/linux (set-face! :face-font "Terminus"
                         :font-height 120))
  ('windows-nt (set-face! :face-font "Terminus (TTF)"
                          :font-height 120)))
