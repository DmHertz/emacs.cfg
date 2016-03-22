;; don't make backup-files
(setq make-backup-files -1)
;; prefs
(setq create-lockfiles nil)
(setq backup-inhibited t)

(setq backup-directory-alist
      `((".*" ,temporary-file-directory)))

(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))
