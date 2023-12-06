;;; -*- lexical-binding: t -*-

(use-package all-the-icons)

(use-package all-the-icons-dired
  :hook
  (dired-mode . all-the-icons-dired-mode))

(use-package chezmoi
  :straight
  (chezmoi :files ("extensions/*.el" "*.el"))
  :init
  (require 'chezmoi-ediff)
  :config
  (advice-add #'chezmoi-ediff
	      :before
	      (lambda (file)
		(setq age-default-identity nil
		      age-default-recipient nil))))

(use-package company
  :hook (after-init . global-company-mode))

(use-package consult
  :bind
  (:map global-map
	("C-s" . consult-line)
	("C-c r" . consult-ripgrep)
	("C-c e" . consult-recent-file)))

(use-package consult-lsp
  :hook
  (lsp-mode . (lambda () (local-set-key (kbd "C-c l f") #'consult-lsp-file-symbols))))

(use-package consult-projectile
  :config
  (define-key projectile-mode-map (kbd "C-c p f") #'consult-projectile-find-file)
  (define-key projectile-mode-map (kbd "C-c p p") #'consult-projectile-switch-project)
  (define-key projectile-mode-map (kbd "C-c p b") #'consult-projectile-switch-to-buffer)
  (define-key projectile-mode-map (kbd "C-c p e") #'consult-projectile-recentf))

(use-package copilot
  :straight
  (copilot :type git :host github :repo "zerolfx/copilot.el" :files ("dist" "*.el")))

(use-package dap-mode
  :bind ("C-c g" . dap-hydra))

(use-package editorconfig)

(use-package ellama
  :init
  (require 'llm-ollama)
  (setopt ellama-provider
	  (make-llm-ollama :chat-model "llama2" :embedding-model "llama2")))

(use-package elfeed
  :bind ("C-x w" . elfeed))

(use-package elfeed-protocol
  :after elfeed)

(use-package embark
  :bind
  (("C-c C-." . embark-act)
   ("C-c C-;" . embark-dwim)))

(use-package embark-consult
  :after (consult embark))

(use-package evil
  :demand t
  :init
  (setq evil-want-integration t
        evil-undo-system 'undo-tree)
  :hook
  ((evil-emacs-state-entry . (lambda () (undo-tree-mode -1)))
   (evil-emacs-state-exit . (lambda () (undo-tree-mode 1))))
  :config
  (evil-mode t)
  (dolist (mode '(comint-mode
		  dired-mode
		  help-mode
		  inferior-emacs-lisp-mode
		  Info-mode
		  Man-mode
		  messages-buffer-mode
		  minibuffer-mode
		  process-menu-mode
		  xref--xref-buffer-mode))
    (add-to-list 'evil-emacs-state-modes mode)
    (evil-set-initial-state mode 'emacs)))

(use-package exec-path-from-shell
  :if (memq window-system '(mac ns x))
  :init
  (setq exec-path-from-shell-arguments nil
	exec-path-from-shell-check-startup-files nil)
  :config
  (dolist (var '("LSP_USE_PLISTS"
		 "GPG_AGENT_INFO"
		 "SSH_AUTH_SOCK"
		 "SSH_AGENT_PID"))
    (add-to-list 'exec-path-from-shell-variables var))
  (exec-path-from-shell-initialize)
  :demand t)

(use-package flycheck
  :config
  (add-to-list 'evil-emacs-state-modes 'flycheck-error-list-mode))

(use-package flycheck-inline
  :after (flycheck))

(use-package lsp-mode
  :init
  (setq read-process-output-max (my-value-to-mb 1))
  :hook
  (lsp-mode . my-increase-gc-threshold)
  :config
  (define-key lsp-mode-map (kbd "C-c l") lsp-command-map))

(use-package lsp-treemacs
  :hook
  (lsp-mode . (lambda () (local-set-key (kbd "C-c l n") #'lsp-treemacs-symbols))))

(use-package lsp-ui
  :config
  (lsp-ui-peek-enable t)
  (add-to-list 'evil-emacs-state-modes 'lsp-ui-imenu-mode))

(use-package magit)

(use-package marginalia
  :init
  (marginalia-mode))

(use-package mood-line
  :config
  (mood-line-mode))

(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles basic partial-completion)))))

(use-package org-present
  :bind
  (("C-c h" . org-present-prev)
   ("C-c l" . org-present-next)))

(use-package projectile
  :bind
  (("C-c p" . projectile-command-map))
  :config
  (projectile-mode 1)
  :demand t
  :init
  (setq projectile-require-project-root t))

(use-package projectile-ripgrep
  :after (projectile ripgrep))

(use-package rainbow-delimiters
  :hook
  (prog-mode . rainbow-delimiters-mode))

(use-package restclient
  :demand t
  :init
  (add-to-list 'auto-mode-alist '("\\.http\\'" . restclient-mode)))

(use-package ripgrep)

(use-package sh-mode
  :straight nil
  :hook (sh-mode . flycheck-mode))

(use-package treemacs
  :bind
  (("C-c n" . treemacs))
  :config
  (add-to-list 'evil-emacs-state-modes 'treemacs-mode))

(use-package treemacs-projectile)

(use-package tree-sitter
  :if (version< emacs-version "29")
  :hook
  (tree-sitter-after-on . tree-sitter-hl-mode)
  :init
  (global-tree-sitter-mode))

(use-package tree-sitter-langs
  :if (version< emacs-version "29"))

(use-package undo-tree
  :init
  (setq undo-tree-history-directory-alist
      `(("." . ,(concat user-emacs-directory "undo-tree"))))
  :config
  (global-undo-tree-mode 1))

(use-package vertico
  :init
  (require 'vertico-buffer)
  :config
  (vertico-mode)
  (vertico-buffer-mode))

(use-package vterm
  :bind (("C-c t" . vterm))
  :config
  (add-to-list 'evil-emacs-state-modes 'vterm-mode))

(use-package yaml-mode)

(use-package yasnippet
  :config
  (yas-global-mode))

(use-package yasnippet-snippets)

(provide 'init-base)
