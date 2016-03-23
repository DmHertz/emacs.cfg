;; +----------------------------------+
;; |   setup Postgres DB access       |
;; +----------------------------------+
(setq sql-postgres-login-params
      '((user :default "postgres")
        (database :default "postgres")
        (server :default "localhost")
        (port :default 5432)))
;; fix truncate
(add-hook 'sql-interactive-mode-hook
          (lambda ()
            (toggle-truncate-lines t)))

;; +----------------------------------+
;; |   setup SQLite3 DB access        |
;; +----------------------------------+

;; It section empty yet.
