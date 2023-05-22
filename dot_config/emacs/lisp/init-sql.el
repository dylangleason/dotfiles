;;; -*- lexical-binding: t -*-

(use-package sqlup-mode
  :hook ((sql-mode . sqlup-mode)
         (sql-interactive-mode . sqlup-mode)))

(add-to-list 'same-window-buffer-names "*SQL*")

(add-hook 'sql-mode-hook
          (lambda ()
            ;; Start new line comment in SQL. MySQL specific.
            (modify-syntax-entry ?# "< b" sql-mode-syntax-table)))

(add-hook 'sql-mode-hook 'sqlup-mode)

(add-hook 'sql-interactive-mode-hook
          (lambda ()
            ;; Modify PostgreSQL prompt to correctly handle
            ;; underscores in database names. WARNING:
            ;; PostgreSQL-specific.
            (setq sql-prompt-regexp "^[_[:alpha:]]*[=][#>] "
                  sql-prompt-cont-regexp "^[_[:alpha:]]*[-][#>] ")))

(provide 'init-sql)
