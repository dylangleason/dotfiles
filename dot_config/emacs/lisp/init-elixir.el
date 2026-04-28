;;; -*- lexical-binding: t -*-

(when (treesit-available-p)
  (my-treesit-add-grammar 'elixir "https://github.com/elixir-lang/tree-sitter-elixir")
  (my-treesit-add-grammar 'heex "https://github.com/phoenixframework/tree-sitter-heex"))

(defun my-elixir-mode-hook ()
  (setq-local flycheck-elixir-credo-strict t)
  (bind-key "C-c p x x" #'inf-elixir-project (current-local-map))
  (add-hook 'before-save-hook #'lsp-format-buffer nil t)
  (flycheck-mode)
  (lsp-deferred))

(use-package elixir-ts-mode
  :if (treesit-language-available-p 'elixir)
  :hook
  (elixir-ts-mode . my-elixir-mode-hook)
  :init
  (add-to-list 'major-mode-remap-alist '(elixir-mode . elixir-ts-mode)))

(use-package elixir-mode
  :unless (treesit-language-available-p 'elixir)
  :hook
  (elixir-mode . my-elixir-mode-hook))

(use-package inf-elixir
  :after (:any elixir-mode elixir-ts-mode)
  :init
  (add-to-list 'evil-emacs-state-modes 'inf-elixir-mode))

(provide 'init-elixir)
