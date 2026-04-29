;; -*- lexical-binding: t; -*-

(when (treesit-available-p)
  (my-treesit-add-grammar
   'php
   "https://github.com/tree-sitter/tree-sitter-php"
   "v0.24.2"
   "php/src"))

(use-package php-ts-mode
  :straight nil
  :mode ("\\.php\\'" . php-ts-mode)
  :interpreter ("php" . php-ts-mode)
  :hook
  ((php-ts-mode . my-php-mode-hook)
   (before-save . lsp-format-buffer))
  :init
  (defun my-php-mode-hook ()
    (setq-local tab-width 4)
    (flycheck-mode)
    (lsp-deferred)))

(provide 'init-php)
