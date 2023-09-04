;;; -*- lexical-binding: t -*-

(defun my-python-mode-hook ()
  (setq-local blacken-mode t)
  ;; (require 'lsp-pyright)
  (flycheck-mode)
  (lsp-deferred))

(use-package blacken
  :after (python-ts-mode))

(use-package hy-mode
  :hook (hy-mode . my-lisp-mode-common-hook)
  :mode "\\.hy\\'")

(use-package lsp-pyright)

(my-treesit-add-grammar 'python "https://github.com/tree-sitter/tree-sitter-python")

(use-package python-ts-mode
  :straight nil
  :mode "\\.py\\'"
  :hook
  (python-ts-mode . my-python-mode-hook)
  :init
  (setq python-shell-interpreter "ipython"
	python-shell-interpreter-args "--simple-prompt -c exec('__import__(\\'readline\\')') -i"))

(use-package python-pytest
  :after (python-ts-mode))

(provide 'init-python)
