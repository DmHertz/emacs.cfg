;;
(defun apply-keybindings (keys-and-fns)
  (dolist (kf keys-and-fns)
    (global-set-key (kbd (car kf)) (cadr kf))))

;; Global set keys
(apply-keybindings
 '(;;; open init file (~/.emacs.d/init.el)
   ("C-x <f3>" (lambda ()
                 (interactive)
                 (find-file user-init-file)))

   ;;; smex
   ("M-x" smex) 
   ("M-X" smex-major-mode-commands)

   ;; company mode
   ("C-c C-i" company-complete)
   ("C-c i" company-complete-common)

   ;; magit
   ("C-x g"   magit-status)
   ("C-x M-g" magit-dispatch-popup)

   ;;; kill this buffer
   ("C-x C-k" kill-this-buffer)

   ;; comment line
   ("C-;"     comment-line)
   ("C-c ;"   comment-line)
   ("C-c C-;" comment-line)

   ;; string rectangle
   ("C-x r v" string-rectangle)

   ;; aligning with whitespaces
   ("C-c <f8>" (lambda ()
                 (interactive)
                 (align-regexp
                  (region-beginning) (region-end) (rx (group (one-or-more space))))))
   ;; aligning with pipes
   ("C-c <f9>" (lambda ()
                 (interactive)
                 (let ((m (region-beginning))
                       (n (region-end)))
                   ;;; firstly move "|" to "| "
                   (save-restriction
                     (narrow-to-region m n)
                     (goto-char m)
                     (while (search-forward "|" nil t)
                       (replace-match "| " nil t)))
                   ;;; aligning
                   (align-regexp m n
                                 (concat "\\(\\s-*\\)" "\\(|\\)") 1 1 t))))
   
   ;;; for easy window scrolling up and down
   ("M-n" scroll-up-line)
   ("M-p" scroll-down-line)

   ;;; Neo tree toggle
   ("<f3>" neotree-toggle)

   ;;; Navigation between windows
   ("<up>"    windmove-up)
   ("<down>"  windmove-down)
   ("<left>"  windmove-left)
   ("<right>" windmove-right)

   ;;; visual way window switching
   ("C-x o" switch-window)
   ;;; Navigation between next-prev buffers
   ("C-x ," previous-buffer)
   ("C-x ." next-buffer)

   ;;; Comment/uncomment block
   ("C-x /"   comment-or-uncomment-region)
   ("C-x C-_" uncomment-region)

   ;;; undo, redo
   ("C-z"   undo)
   ("C-M-z" redo)

   ;;; save
   ("<f2>" save-buffer)

   ;;; insert char
   ("<f6>" insert-char)

   ;;; line highlighting
   ("<f7>" hl-line-mode)

   ;;; linum
   ("<f8>" linum-mode)

   ;;; compare windows
   ("C-c w" compare-windows)

   ;;; cyrillic binds
   ("C-а" forward-char)
   ("C-и" backward-char)

   ("M-а" forward-word)
   ("M-и" backward-word)

   ("C-ф" move-beginning-of-line)
   ("C-у" move-end-of-line)

   ("C-з" previous-line)
   ("C-т" next-line)

   ("C-м" scroll-up)
   ("M-м" scroll-down)
   
   ;;; snippets                                                  
   ("C-c <f10>" debian-control-description)))

;;; org-mode                               
(when (equalp major-mode 'org-mode)
  (apply-keybindings
   ("C-cl" org-store-link)
   ("C-ca" org-agenda)
   ("C-cc" org-capture)
   ("C-cb" org-iswitchb)))

;;; symbols
(when (equalp major-mode 'racket-mode)
  (global-set-key (kbd "C-\\") "λ")) 

(provide 'keybindings-cfg)
