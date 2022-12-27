;;; -*- lexical-binding: t -*-

;;; basic configuration

(defun my-line-numbers-mode ()
  (display-line-numbers-mode)
  (setq display-line-numbers-type 'visual))

(when (version< emacs-version "27")
  (load (concat user-emacs-directory) "early-init"))

(unless (version< emacs-version "26")
  (add-hook 'prog-mode-hook 'my-line-numbers-mode))

(with-eval-after-load 'package
  (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/")))

(setq backup-by-copying t
      backup-directory-alist `(("." . ,(concat user-emacs-directory "backup")))
      delete-old-versions t
      kept-new-versions 5
      kept-old-versions 5
      version-control t)

(setq load-prefer-newer t
      read-process-output-max (* 1024 1024))

(setq ring-bell-function 'ignore)

(setq custom-file (concat user-emacs-directory "custom.el"))
(load custom-file t)

(global-prettify-symbols-mode 1)
(prefer-coding-system 'utf-8)
(put 'dired-find-alternate-file 'disabled nil)

;;; essential packages

(package-initialize)

(unless (package-installed-p 'use-package)  
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package)
  (setq use-package-always-defer t)
  (setq use-package-always-ensure t))

(use-package evil
  :after undo-tree
  :demand t
  :init
  (setq evil-want-integration t
        evil-undo-system 'undo-tree)
  :hook
  ((evil-emacs-state-entry . (lambda () (undo-tree-mode -1)))
   (evil-emacs-state-exit . (lambda () (undo-tree-mode 1))))
  :config
  (evil-mode t)
  (dolist (mode '(dired-mode
		  flycheck-error-list-mode
		  help-mode
		  Info-mode
		  minibuffer-mode
		  vterm-mode
		  xref--xref-buffer-mode))
    (add-to-list 'evil-emacs-state-modes mode)))

(use-package exec-path-from-shell
  :init
  (setq exec-path-from-shell-arguments nil
	exec-path-from-shell-check-startup-files nil)
  :config
  (when (memq window-system '(mac ns x))
    (exec-path-from-shell-initialize)))

(use-package magit)

(use-package marginalia
  :init
  (marginalia-mode))

(when (version< emacs-version "28")
  (use-package modus-themes))

(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles basic partial-completion)))))

(use-package projectile
  :bind
  (("C-c p" . projectile-command-map))
  :config
  (projectile-mode 1)
  :demand t
  :init
  (setq projectile-require-project-root t))

(use-package undo-tree
  :init
  (global-undo-tree-mode 1))

(use-package vertico
  :init
  (vertico-mode))

(use-package vertico-buffer
  :after vertico
  :ensure nil
  :init
  (vertico-buffer-mode))

(use-package vterm
  :ensure nil
  :bind (("C-c t" . vterm)))

(load (concat user-emacs-directory "lang"))
