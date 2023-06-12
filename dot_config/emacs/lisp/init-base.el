;;; -*- lexical-binding: t -*-

(use-package company
  :hook (after-init . global-company-mode))

(use-package elfeed
  :bind ("C-x w" . elfeed))

(use-package dap-mode
  :bind ("C-c g" . dap-hydra))

(use-package elfeed-protocol
  :after elfeed)

(use-package embark
  :bind
  (("C-c C-." . embark-act)
   ("C-c C-;" . embark-dwim)))

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
  (dolist (mode '(dired-mode
		  help-mode
		  Info-mode
		  Man-mode
		  messages-buffer-mode
		  minibuffer-mode
		  process-menu-mode
		  xref--xref-buffer-mode))
    (add-to-list 'evil-emacs-state-modes mode)))

(use-package exec-path-from-shell
  :if (memq window-system '(mac ns x))
  :init
  (setq exec-path-from-shell-arguments nil
	exec-path-from-shell-check-startup-files nil)
  :config
  (exec-path-from-shell-initialize)
  :demand t)

(use-package flycheck
  :config
  (add-to-list 'evil-emacs-state-modes 'flycheck-error-list-mode))

(use-package flycheck-inline
  :after (flycheck))

(use-package lsp-mode
  :init
  (setq read-process-output-max 8192)
  :config
  (define-key lsp-mode-map (kbd "C-c l") lsp-command-map))

(use-package lsp-ui
  :bind
  (:map prog-mode-map ("M-j" . lsp-ui-imenu))
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

(use-package treemacs
  :bind
  (("C-c n" . treemacs))
  :config
  (add-to-list 'evil-emacs-state-modes 'treemacs-mode))

(use-package treemacs-projectile)

(use-package tree-sitter
  :hook
  (tree-sitter-after-on . tree-sitter-hl-mode)
  :init
  (global-tree-sitter-mode))

(use-package tree-sitter-langs
  :after (tree-sitter))

(use-package undo-tree
  :init
  (global-undo-tree-mode 1))

(use-package vertico
  :init
  (vertico-mode))

(use-package vertico-buffer
  :after vertico
  :straight nil
  :init
  ;; NOTE: straight does not automatically export this extension into
  ;; the main repo directory. Must manually copy from
  ;; `extensions/vertico-buffer.el` to parent repo directory.
  (vertico-buffer-mode))

(use-package vterm
  :bind (("C-c t" . vterm))
  :config
  (add-to-list 'evil-emacs-state-modes 'vterm-mode))

(use-package yaml-mode)

(provide 'init-base)
