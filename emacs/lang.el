;;; -*- lexical-binding: t -*-

(defun my-lisp-mode-common-hook ()
  (enable-paredit-mode)
  (rainbow-delimiters-mode-enable))

(use-package company
  :hook (after-init . global-company-mode))

(use-package dash)

(use-package emacs-lisp-mode
  :ensure nil
  :hook (emacs-lisp-mode . my-lisp-mode-common-hook))

(use-package flycheck
  :after (dash))

(use-package flycheck-inline
  :after (flycheck))

(use-package geiser-guile
  :ensure nil
  :hook (geiser-repl-mode . my-lisp-mode-common-hook))

(use-package go-mode
  :hook
  ((go-mode . (lambda ()
                (rainbow-delimiters-mode-enable)
                (flycheck-mode)
                (setq lsp-go-env '((GOFLAGS . "--tags=wireinject")))
                (lsp-deferred)))
   (before-save . lsp-format-buffer)
   (before-save . lsp-organize-imports)))

(use-package lsp-mode
  :init
  (setq read-process-output-max 8192)
  :config
  (define-key lsp-mode-map (kbd "C-c l") lsp-command-map))

(use-package paredit)

(use-package rainbow-delimiters)

(use-package scheme-mode
  :ensure nil
  :hook (scheme-mode . my-lisp-mode-common-hook))
