;;; -*- lexical-binding: t -*-

(defun my-go-mode-hook ()
  (flycheck-mode)
  (setq lsp-go-use-gofumpt t
	lsp-go-env '((GOFLAGS . "--tags=wireinject")))
  (setq-local compile-command "go build -gcflags=\"all=-N -l\" .")
  (lsp-deferred)
  (copilot-mode))

(defun my-go-before-save-hook ()
  (lsp-format-buffer)
  (lsp-organize-imports))

(unless (version< emacs-version "29")
  (my-treesit-add-grammar 'go "https://github.com/tree-sitter/tree-sitter-go"))

(use-package go-ts-mode
  :if (treesit-language-available-p 'go)
  :straight nil
  :hook
  ((go-ts-mode . my-go-mode-hook)
   (before-save . my-go-before-save-hook))
  :config
  (require 'dap-dlv-go)
  :init
  (add-to-list 'major-mode-remap-alist '(go-mode . go-ts-mode)))

(use-package go-mode
  :if (not (treesit-language-available-p 'go))
  :hook
  ((go-mode . my-go-mode-hook)
   (before-save . my-go-before-save-hook))
  :config
  (require 'dap-dlv-go))

(use-package gotest)

(provide 'init-go)
