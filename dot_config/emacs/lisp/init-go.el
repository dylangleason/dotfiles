;; -*- lexical-binding: t; -*-

(when (treesit-available-p)
  (my-treesit-add-grammar 'go "https://github.com/tree-sitter/tree-sitter-go")
  (my-treesit-add-grammar 'gomod "https://github.com/camdencheek/tree-sitter-go-mod"))

(defun my-go-before-save-hook ()
  (lsp-format-buffer)
  (lsp-organize-imports))

(defun my-go-mode-hook ()
  (setq lsp-go-use-gofumpt t
	lsp-go-env '((GOFLAGS . "--tags=wireinject")))
  (setq-local compile-command "go build -gcflags=\"all=-N -l\" .")
  (require 'dap-dlv-go)
  (add-hook 'before-save-hook #'my-go-before-save-hook nil t)
  (flycheck-mode)
  (lsp-deferred))

(defun golines ()
  (interactive)
  (shell-command-on-region
   (point-min)
   (point-max)
   "golines -m 100"
   (current-buffer)
   t
   "*Golines Error Buffer*"
   t))

(use-package go-ts-mode
  :if (treesit-language-available-p 'go)
  :straight nil
  :hook
  (go-ts-mode . my-go-mode-hook)
  :init
  (add-to-list 'major-mode-remap-alist '(go-mode . go-ts-mode)))

(use-package go-mode
  :unless (treesit-language-available-p 'go)
  :hook (go-mode . my-go-mode-hook))

(use-package gotest)

(provide 'init-go)
