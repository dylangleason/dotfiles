;;; -*- lexical-binding: t -*-

(when (treesit-available-p)
  (my-treesit-add-grammar 'ruby "https://github.com/tree-sitter/tree-sitter-ruby"))

(defconst ruby-modes-regexp
 "\\(?:\\.rb\\|ru\\|rake\\|thor\\|jbuilder\\|gemspec\\|podspec\\|/\\(?:Gem\\|Rake\\|Cap\\|Thor\\|Vagrant\\|Guard\\|Pod\\)file\\)\\'")

(defun my-ruby-mode-hook ()
  (add-hook 'before-save #'lsp-format-buffer nil t)
  (flycheck-mode)
  (rubocop-mode)
  (lsp-deferred))

(use-package inf-ruby)

(use-package projectile-rails
  :after (projectile (:any ruby-mode ruby-ts-mode)))

(use-package rspec-mode
  :after (:any ruby-mode ruby-ts-mode))

(use-package rubocop
  :after (ruby-mode)
  :config
  (advice-add 'rubocop-build-command :override #'my-rubocop-build-command)
  :init
  (defun my-rubocop-build-command (command path)
    (concat command
	    (rubocop-build-requires)
	    " "
	    path)))

(use-package ruby-ts-mode
  :if (treesit-available-p)
  :straight nil
  :hook
  (ruby-ts-mode . my-ruby-mode-hook)
  :init
  (add-to-list 'auto-mode-alist (cons ruby-modes-regexp 'ruby-ts-mode))
  (add-to-list 'major-mode-remap-alist '(ruby-mode . ruby-ts-mode))
  :interpreter "ruby")

(use-package ruby-mode
  :unless (treesit-available-p)
  :straight nil
  :hook
  (ruby-mode . my-ruby-mode-hook)
  :init
  (add-to-list 'auto-mode-alist (cons ruby-modes-regexp 'ruby-ts-mode))
  :interpreter "ruby")

(provide 'init-ruby)
