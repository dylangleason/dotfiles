;;; -*- lexical-binding: t -*-

(defun my-ruby-mode-hook ()
  (flycheck-mode)
  (rubocop-mode)
  (lsp-deferred))

(defun my-rubocop-build-command (command path)
  (concat command
	  (rubocop-build-requires)
	  " "
	  path))

(use-package inf-ruby)

(use-package projectile-rails
  :after (projectile ruby-mode))

(use-package rspec-mode
  :after (ruby-mode))

(use-package rubocop
  :after (ruby-mode)
  :config
  (advice-add 'rubocop-build-command :override #'my-rubocop-build-command))

(use-package ruby-mode
  :straight nil
  :mode "\\(?:\\.rb\\|ru\\|rake\\|thor\\|jbuilder\\|gemspec\\|podspec\\|/\\(?:Gem\\|Rake|Cap\\|Thor\\|Vagrant\\|Guard\\|Pod\\)file\\)\\'"
  :hook (ruby-mode . my-ruby-mode-hook)
  :interpreter "ruby")

(use-package yari
  :after (ruby-mode))

(provide 'init-ruby)
