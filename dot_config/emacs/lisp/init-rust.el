;; -*- lexical-binding: t; -*-

(when (treesit-available-p)
  (my-treesit-add-grammar 'rust "https://github.com/tree-sitter/tree-sitter-rust"))

(use-package rust-ts-mode
  :if (treesit-language-available-p 'rust)
  :straight nil
  :hook
  ((rust-ts-mode . my-rust-mode-hook)
   (before-save . lsp-format-buffer))
  :init
  (defun my-rust-mode-hook ()
    (setq-local compile-command "rustc")
    (flycheck-mode)
    (lsp-deferred))
  (add-to-list 'major-mode-remap-alist '(rust-mode . rust-ts-mode)))

(use-package flycheck-rust
  :init
  (with-eval-after-load 'rust-ts-mode
    (add-hook 'flycheck-mode-hook #'flycheck-rust-setup)))

(use-package ron-mode)

(provide 'init-rust)
