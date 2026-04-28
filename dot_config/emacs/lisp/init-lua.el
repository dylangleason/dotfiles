;;; -*- lexical-binding: t -*-

(when (treesit-available-p)
  (my-treesit-add-grammar 'lua "https://github.com/tree-sitter-grammars/tree-sitter-lua"))

(defun my-lua-mode-hook ()
  (setq-local lua-indent-level 2)
  (setq-local indent-tabs-mode nil)
  (flycheck-mode)
  (lsp-deferred))

(defconst lua-modes-regexp
  "\\(\\.lua\\|\\.script\\)\\'")

(use-package company-lua
  :demand t
  :init
  (with-eval-after-load 'company-mode
    (add-to-list 'company-backends 'company-lua)))

(use-package lua-ts-mode
  :straight nil
  :if (treesit-language-available-p 'lua)
  :hook (lua-ts-mode . my-lua-mode-hook)
  :init
  (add-to-list 'auto-mode-alist (cons lua-modes-regexp 'lua-ts-mode))
  (add-to-list 'major-mode-remap-alist '(lua-mode . lua-ts-mode)))

(use-package lua-mode
  :unless (treesit-language-available-p 'lua)
  :hook (lua-mode . my-lua-mode-hook)
  :init
  (add-to-list 'auto-mode-alist (cons lua-modes-regexp 'lua-mode)))

(provide 'init-lua)
