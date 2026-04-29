;; -*- lexical-binding: t; -*-

(use-package sql-mode
  :straight nil
  :hook
  (sql-mode . my-sql-mode-hook)
  :init
  (defun my-sql-mode-hook ()
    ;; Start new line comment in SQL. MySQL specific.
    (modify-syntax-entry ?# "< b" sql-mode-syntax-table)))

(use-package sql-interactive-mode
  :straight nil
  :hook 
  (sql-interactive-mode . my-sql-interactive-mode-hook)
  :init
  (defun my-sql-interactive-mode-hook ()
    ;; Modify PostgreSQL prompt to correctly handle
    ;; underscores in database names. WARNING:
    ;; PostgreSQL-specific.
    (setq sql-prompt-regexp "^[_[:alpha:]]*[=][#>] "
          sql-prompt-cont-regexp "^[_[:alpha:]]*[-][#>] "))
  (add-to-list 'same-window-buffer-names "*SQL*"))

(use-package sqlup-mode
  :hook
  ((sql-mode . sqlup-mode)
   (sql-interactive-mode . sqlup-mode)))

(use-package sql-indent
  :init
  (setq sqlind-basic-offset 4)
  :hook
  ((sql-mode . sqlind-minor-mode)))

(provide 'init-sql)
