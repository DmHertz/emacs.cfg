;; Interface setup ;; -*- lexical-binding: t; -*-
(load-theme 'solarized-dark t)

(setq bg-color "#000000"
      face-font-height 120
      face-font-step 10
      ;; font | arch package
      face-fonts '("Terminus"       ;; terminus-font
                   "Terminus (TTF)" ;; terminus-font-ttf (aur)
                   "Inconsolata"    ;; ttf-inconsolata
                   "spleen"
                   "Monospace"
                   "Liberation Mono"
                   "DejaVu Sans Mono"
                   "Consolas")
      default-face-font (pcase distro
                          ('arch
                           (cadr face-fonts))
                          ((or 'ubuntu 'lsb)
                           (car  face-fonts))
                          ('OpenBSD
                           (cadddr face-fonts))
                          ('windows-nt
                           (last face-fonts))))

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
                                        80 face-font-height))))

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

(provide 'interface-cfg)
