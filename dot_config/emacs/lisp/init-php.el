;; -*- lexical-binding: t; -*-

(when (and (treesit-available-p)
           (not (treesit-language-available-p 'php)))
  (php-ts-mode-install-parsers))

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
