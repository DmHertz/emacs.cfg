;; -*- lexical-binding: t; -*-
(require 'dired+)
(require 'image-dired+)

(let ((dired-async-file (expand-file-name
                         (concat user-emacs-directory
                                 "el-get/emacs-async/"
                                 "dired-async.el"))))
  (if (file-exists-p dired-async-file)
      (autoload 'dired-async-mode dired-async-file nil t)
    (message "dired-async.el not found")))

;;; show details always
(setq diredp-hide-details-initially-flag nil
      diredp-hide-details-propagate-flag nil)

(provide 'dired-cfg)
