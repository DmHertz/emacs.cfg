;;; exec path
;; (defun append-exec-paths (paths separator)
;;   (setenv "PATH"
;;           (-> (getenv "PATH")
;;               (concat (mapconcat 'identity (cons "" paths) separator))))
;;   (->> paths
;;        (append exec-path)
;;        (setq exec-path)))

;; (case system-type
;;   ('gnu/linux (append-exec-paths
;;                (list "/opt/hz/bin") ":"))
;;   ('windows-nt (append-exec-paths
;;                 (list "C:/Program Files (x86)/Microsoft SDKs/F#/4.0/Framework/v4.0") ";")))

;; (setq eshell-aliases-file "~/.emacs.d/eshell/alias")
