;;; -*- lexical-binding: t -*-

(defun my-python-mode-hook ()
  (blacken-mode)
  (flycheck-mode)
  (lsp-deferred))

(defun my-python-init ()
  (setq python-shell-interpreter "ipython"
	python-shell-interpreter-args "--simple-prompt -c exec('__import__(\\'readline\\')') -i"))

(use-package blacken
  :after (:any (python-mode python-ts-mode)))

(use-package hy-mode
  :hook (hy-mode . my-lisp-mode-common-hook)
  :mode "\\.hy\\'")

(use-package lsp-pyright)

(unless (version< emacs-version "29")
  (my-treesit-add-grammar 'python "https://github.com/tree-sitter/tree-sitter-python"))

(use-package python-ts-mode
  :if (treesit-language-available-p 'python)
  :straight nil
  :hook
  (python-ts-mode . my-python-mode-hook)
  :init
  (add-to-list 'major-mode-remap-alist '(python-mode . python-ts-mode))
  (my-python-init))

(use-package python-mode
  :if (not (treesit-language-available-p 'python))
  :straight nil
  :hook
  (python-mode . my-python-mode-hook)
  :init
  (my-python-init))

(use-package python-pytest)

(provide 'init-python)
