;;; -*- lexical-binding: t -*-

(use-package org
  :demand t)

(use-package org-compat
  :after org
  :straight nil)

(org-babel-do-load-languages
 'org-babel-load-languages
 '((python . t)))

(use-package all-the-icons)

(use-package all-the-icons-dired
  :hook
  (dired-mode . all-the-icons-dired-mode))

(use-package base16-theme
  :demand t
  :init
  (setq custom-safe-themes t)
  :config
  (load-theme 'base16-irblack))

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
  :hook (lsp-mode . my-lsp-bind-local-keymap)
  :init
  (defun my-lsp-bind-local-keymap ()
    (bind-key "C-c l f" #'consult-lsp-file-symbols 'lsp-mode-map)
    (bind-key [remap xref-find-apropos] #'consult-lsp-symbols 'lsp-mode-map)))

(use-package consult-projectile
  :hook (projectile-mode . my-projectile-bind-local-keymap)
  :init
  (defun my-projectile-bind-local-keymap ()
    (bind-key "C-c p f" #'consult-projectile-find-file 'projectile-mode-map)
    (bind-key "C-c p p" #'consult-projectile-switch-project 'projectile-mode-map)
    (bind-key "C-c p b" #'consult-projectile-switch-to-buffer 'projectile-mode-map)
    (bind-key "C-c p e" #'consult-projectile-recentf 'projectile-mode-map)))

(use-package codex-cli
  :init
  (setq codex-cli-executable "codex"
        codex-cli-terminal-backend 'vterm
        codex-cli-side 'right))

(use-package copilot
  :straight
  (copilot :type git :host github :repo "copilot-emacs/copilot.el" :files ("dist" "*.el")))

(use-package dap-mode
  :bind ("C-c g" . dap-hydra))

(use-package editorconfig)

(use-package ellama
  :init
  (setopt ellama-auto-scroll t
          ellama-sessions-directory "~/Documents/ellama-sessions")
  (require 'llm-ollama)
  (setopt ellama-provider
          (make-llm-ollama :chat-model "gemma3:latest"
                           :embedding-model "gemma3:latest")))

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
                  eww-mode
                  help-mode
                  inferior-emacs-lisp-mode
                  inferior-python-mode
                  Info-mode
                  Man-mode
                  messages-buffer-mode
                  Messages
                  minibuffer-mode
                  process-menu-mode
                  geiser-repl-mode
                  slime-repl-mode
                  tab-switcher-mode
                  xref--xref-buffer-mode))
    (add-to-list 'evil-emacs-state-modes mode)
    (evil-set-initial-state mode 'emacs)))

(use-package exec-path-from-shell
  :if (memq window-system '(mac ns))
  :init
  (setq exec-path-from-shell-arguments nil
        exec-path-from-shell-check-startup-files nil)
  :config
  (dolist (var '("C_INCLUDE_PATH"
                 "LSP_USE_PLISTS"
                 "GOPATH"
                 "GPG_AGENT_INFO"
                 "GUILE_LOAD_PATH"
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

(use-package gptel
  :config
  (require 'gptel-integrations)
  (require 'gptel-org)
  :init
  (setq gptel-model 'gpt-4.1
        gptel-default-mode 'org-mode))

(use-package graphviz-dot-mode)

(use-package languagetool
  :commands (languagetool-check
             languagetool-clear-suggestions
             languagetool-correct-at-point
             languagetool-correct-buffer
             languagetool-set-language
             languagetool-server-mode
             languagetool-server-start
             languagetool-server-stop)
  :init
  (setq languagetool-java-arguments
        '("-Dfile.encoding=UTF-8"
          "-cp" "/usr/share/languagetool:/usr/share/java/languagetool/*")
        languagetool-console-command
        "org.languagetool.commandline.Main"
        languagetool-server-command
        "org.languagetool.server.HTTPServer")

  ;; (setq languagetool-java-arguments '("-Dfile.encoding=UTF-8")
  ;;       languagetool-console-command "/usr/bin/languagetool"
  ;;       languagetool-server-command "/usr/bin/languagetool")
  )

(use-package lsp-mode
  :hook (lsp-mode . my-increase-gc-threshold)
  :custom (lsp-keymap-prefix "C-c l")
  :config
  ;; use expert-elixir instead of elixir-ls
  (add-to-list 'lsp-disabled-clients 'elixir-ls)
  (lsp-register-client
   (make-lsp-client
    :new-connection (lsp-stdio-connection
                     '("~/.local/bin/expert_linux_amd64" "--stdio"))
    :activation-fn (lsp-activate-on "elixir")
    :server-id 'expert-elixir))
  :init
  (setq read-process-output-max (my-value-to-mb 1)))

(use-package lsp-treemacs
  :config
  (lsp-treemacs-sync-mode 1)
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
  (mood-line-mode)
  :demand t)

(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles basic partial-completion)))))

(use-package org-present
  :bind
  (("C-c h" . org-present-prev)
   ("C-c l" . org-present-next)))

(use-package projectile
  :config
  (projectile-mode 1)
  :custom (projectile-keymap-prefix "C-c p")
  :demand t
  :init
  (setq projectile-require-project-root t))

(use-package projectile-ripgrep
  :after (projectile ripgrep))

(use-package rainbow-delimiters
  :hook
  (prog-mode . rainbow-delimiters-mode))

(add-to-list 'load-path (concat user-emacs-directory "site-lisp/reajs-mode"))
(use-package reajs-mode
  :straight nil
  :mode "\\.jsfx\\'")

(use-package ripgrep)

(use-package sh-mode
  :straight nil
  :hook (sh-mode . flycheck-mode))

(use-package tab-bar
  :straight nil
  :init
  (defun my-projectile-switch-project-in-new-tab (f &rest args)
    (let ((project (car args)))
      (tab-new)
      (apply f args)
      (tab-bar-rename-tab (file-name-nondirectory (directory-file-name project)))))

  (defun my-toggle-projectile-tab-mode-advice ()
    (if tab-bar-mode
	(advice-add #'projectile-switch-project-by-name
		    :around #'my-projectile-switch-project-in-new-tab)
      (advice-remove #'projectile-switch-project-by-name
		     #'my-projectile-switch-project-in-new-tab)))
  :hook
  (tab-bar-mode . my-toggle-projectile-tab-mode-advice))

(use-package treemacs
  :bind
  (("C-c n" . treemacs))
  :config
  (add-to-list 'evil-emacs-state-modes 'treemacs-mode))

(use-package treemacs-projectile)

(use-package uuidgen)

(use-package undo-tree
  :init
  (setq undo-tree-history-directory-alist
        `(("." . ,(concat user-emacs-directory "undo-tree"))))
  :hook
  ((evil-local-mode . undo-tree-mode)))

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

(use-package which-key
  :straight nil
  :init
  (which-key-mode)
  :config
  (setq which-key-idle-delay 0.8))

(provide 'init-base)
