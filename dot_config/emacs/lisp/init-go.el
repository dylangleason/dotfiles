;;; -*- lexical-binding: t -*-

(defun my-go-mode-hook ()
  (rainbow-delimiters-mode-enable)
  (flycheck-mode)
  (setq lsp-go-env '((GOFLAGS . "--tags=wireinject")))
  (lsp-deferred))

(use-package flycheck-gometalinter
  :after (flycheck go-mode)
  :init
  (setq flycheck-gometalinter-fast t
	flycheck-gometalinter-vendor t
	flycheck-gometalinter-enable-linters '("golint"))
  :config
  (flycheck-go-metalinter-setup))

(use-package go-mode
  :hook
  ((go-mode . my-go-mode-hook)
   (before-save . lsp-format-buffer)
   (before-save . lsp-organize-imports)))

(use-package gotest
  :after (go-mode))

(provide 'init-go)
