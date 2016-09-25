

;; How to open new website in new buffer?
;; Call rename-buffer to rename the first one.
;; Then, call eww again to open a new site.
;; You can write a hook to rename automatically. Put this in your emacs init.
(when (fboundp 'eww)
  (progn
    (defun xah-rename-eww-hook ()
      "Rename eww browser's buffer so sites open in new page."
      (rename-buffer "eww" t))
    (add-hook 'eww-mode-hook 'xah-rename-eww-hook)))

(provide 'eww-cfg)
