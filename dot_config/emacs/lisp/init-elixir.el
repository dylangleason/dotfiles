;;; -*- lexical-binding: t -*-

(defun my-elixir-mode-hook ()
  (flycheck-mode)
  (lsp-deferred))

(use-package elixir-mode
  :hook
  ((elixir-mode . my-elixir-mode-hook)
   (before-save . elixir-format)))

(use-package flycheck-elixir
  :after (elixir-mode))

(use-package inf-elixir
  :after
  (elixir-mode)
  :init
  (add-to-list 'evil-emacs-state-modes 'inf-elixir-mode))

(provide 'init-elixir)
