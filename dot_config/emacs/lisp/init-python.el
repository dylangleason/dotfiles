;;; -*- lexical-binding: t -*-

(use-package blacken
  :after (python)
  :hook
  (python-mode . (lambda () (setq-local blacken-mode t))))

(use-package hy-mode
  :hook (hy-mode . my-lisp-mode-common-hook)
  :mode ("\\.hy\\'" . hy-mode))

(use-package lsp-pyright
  :hook
  (python-mode . (lambda ()
		   (require 'lsp-pyright)
		   (lsp-deferred))))

(use-package python
  :straight nil
  :hook
  (python-mode . flycheck-mode)
  :init
  (setq python-shell-interpreter "ipython"
	python-shell-interpreter-args "--simple-prompt -c exec('__import__(\\'readline\\')') -i"))

(use-package python-pytest
  :after (python))

(provide 'init-python)
