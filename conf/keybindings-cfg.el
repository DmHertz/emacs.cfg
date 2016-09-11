;; Global set keys

;;; open init file (~/.emacs.d/init.el)
(global-set-key (kbd "C-x <f3>") (lambda ()
                                   (interactive)
                                   (find-file user-init-file)))
;;; smex
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
;; kill this buffer
(global-set-key (kbd "C-x C-k") 'kill-this-buffer)
;; kill region
;;(global-set-key (kbd "C-c C-k") #'kill-region)
;; backward kill region
;;(global-set-key "\C-w" #'backward-kill-word)
;; For easy window scrolling up and down
(global-set-key "\M-n" 'scroll-up-line)
(global-set-key "\M-p" 'scroll-down-line)
;; Neo tree toggle
(global-set-key [f3] 'neotree-toggle)
;; Navigation between windows
;;(windmove-default-keybindings 'super) ;; with <key>+arrow-keys

(global-set-key [up] 'windmove-up)
(global-set-key [down] 'windmove-down)
(global-set-key [left] 'windmove-left)
(global-set-key [right] 'windmove-right)
;; symbols
(global-set-key (kbd "C-\\") "λ")
;; visual way window switching
(global-set-key (kbd "C-x o") 'switch-window)
;; Comment/uncomment block
(global-set-key (kbd "C-x /") 'comment-or-uncomment-region)
(global-set-key (kbd "C-x C-_") 'uncomment-region)

;; Navigation between next-prev buffers
(global-set-key (kbd "C-x ,") 'previous-buffer)
(global-set-key (kbd "C-x .") 'next-buffer)
;; f10 — call macro
;; f11 — start macro
;; f12 — end macro
;;(global-set-key [f10] 'kmacro-call-macro)
;;(global-set-key [f11] 'kmacro-start-macro-or-insert-counter)
;;(global-set-key [f12] 'kmacro-end-or-call-macro)
;; undo, redo
(global-set-key (kbd "C-z") 'undo)
(global-set-key (kbd "C-M-z") 'redo)
;; save
(global-set-key [f2] 'save-buffer)
;; insert char
(global-set-key [f6] 'insert-char)
;; line highlighting
(global-set-key [f7] 'hl-line-mode)
;; linum
(global-set-key [f8] 'linum-mode)

(global-set-key (kbd "C-c w") 'compare-windows)
;; parinfer
;;(global-set-key (kbd "C-c <f8>") 'parinfer-mode)

;;; cyrillic binds
(global-set-key (kbd "C-а") 'forward-char)
(global-set-key (kbd "C-и") 'backward-char)

(global-set-key (kbd "M-а") 'forward-word)
(global-set-key (kbd "M-и") 'backward-word)

(global-set-key (kbd "C-ф") 'move-beginning-of-line)
(global-set-key (kbd "C-у") 'move-end-of-line)

(global-set-key (kbd "C-з") 'previous-line)
(global-set-key (kbd "C-т") 'next-line)
;;; snippets
(global-set-key (kbd "C-c <f10>") 'debian-control-description)

(provide 'keybindings-cfg)
