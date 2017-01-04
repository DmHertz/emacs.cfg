;; -*- lexical-binding: t; -*-
;; +----------------------------------+
;; |   setup global db settings       |
;; +----------------------------------+
;; (setq sql-connection-alist
;;       '((server1 (sql-product 'postgres)
;;                   (sql-port 5432)
;;                   (sql-server "localhost")
;;                   (sql-user "user")
;;                   (sql-password "password")
;;                   (sql-database "db1"))
;;         (server2 (sql-product 'postgres)
;;                   (sql-port 5432)
;;                   (sql-server "localhost")
;;                   (sql-user "user")
;;                   (sql-password "password")
;;                   (sql-database "db2"))))
(setq sql-connection-alist
      '((gapps-nsu-local (sql-product 'sqlite)
                         (sql-database "~/Downloads/latest.sqlite"))
        (psql-hometest (user :default "postgres")
                       (database :default "postgres")
                       (server :default "localhost")
                       (port :default 5432))))
;; +----------------------------------+
;; |   define fns for connections     |
;; +----------------------------------+

(defun sql-connect-to-lgapps ()
  (interactive)
  (sql-db-connect 'sqlite 'gapps-nsu-local))

;; (defun my-sql-server2 ()
;;   (interactive)
;;   (sql-db-connect 'postgres 'server2))

(defun sql-db-connect (product connection)
  ;; remember to set the sql-product, otherwise,
  ;; it will fail for the first time
  ;; you call the function
  (setq sql-product product)
  (sql-connect connection))

;; +----------------------------------+
;; |   sql/db hooks                   |
;; +----------------------------------+

;; fix truncate
(add-hook 'sql-interactive-mode-hook
          (lambda ()
            (toggle-truncate-lines t)))

(add-hook 'sql-interactive-mode-hook
          (lambda ()
            (let ((lval 'sql-input-ring-file-name)
                  (rval 'sql-product)
                  (sqldir "~/.emacs.d/sql/"))
              (when (not (file-exists-p sqldir))
                (make-directory sqldir))
              (if (symbol-value rval)
                  (let ((filename 
                         (concat sqldir
                                 (symbol-name (symbol-value rval))
                                 "-history.sql")))
                    (set (make-local-variable lval) filename))
                (error
                 (format "SQL history will not be saved because %s is nil"
                         (symbol-name rval)))))))
;;; -----------------------------------
(provide 'db-cfg)
