;;; -*- lexical-binding: t -*-

(when (treesit-available-p)
  (my-treesit-add-grammar 'clojure "https://github.com/sogaiu/tree-sitter-clojure"))

(defun my-cider-mode-hook ()
  (company-mode)
  (enable-paredit-mode))

(defun my-cider-repl-mode-hook ()
  (company-mode)
  (enable-paredit-mode)
  (local-set-key (kbd "C-c C-b") 'cider-repl-clear-buffer))

(defun my-clojure-mode-hook ()
  (setq enable-completion-at-point nil)
  (enable-paredit-mode))

(use-package cider
  :defines enable-paredit-mode
  :hook
  ((cider-mode . my-cider-mode-hook)
   (cider-repl-mode . my-cider-repl-mode-hook))
  :init
  (setq cider-repl-display-help-banner nil)
  :config
  (add-to-list 'evil-emacs-state-modes 'cider-repl-mode)
  (add-to-list 'evil-emacs-state-modes 'cider-stacktrace-mode))

(use-package paredit
  :bind (:map paredit-mode-map ("RET" . nil)))

(use-package clojure-ts-mode
  :hook (clojure-ts-mode . my-clojure-mode-hook)
  :init
  (add-to-list 'major-mode-remap-alist '(clojure-mode . clojure-ts-mode)))

(use-package clojure-mode
  :unless (treesit-language-available-p 'clojure)
  :hook (clojure-mode . my-clojure-mode-hook))

(use-package emacs-lisp-mode
  :straight nil
  :mode "\\(\\.el\\|Cask\\)\\'"
  :hook ((emacs-lisp-mode . enable-paredit-mode)
	 (ielm-mode . enable-paredit-mode)))

(use-package geiser
  :hook (geiser-repl-mode . enable-paredit-mode))

(use-package geiser-guile)

(use-package geiser-mit)

(use-package hy-mode
  :hook (hy-mode . enable-paredit-mode)
  :mode "\\.hy\\'")

(use-package scheme-mode
  :straight nil
  :hook (scheme-mode . enable-paredit-mode))

(use-package slime
  :hook
  ((slime-mode . enable-paredit-mode)
   (slime-repl-mode . enable-paredit-mode))
  :init
  (setq inferior-lisp-program "sbcl"
        slime-protocol-version 'ignore)
  :config
  (slime-setup '(slime-repl
                 slime-asdf
                 slime-fancy
                 slime-company))
  (let ((hs-docs "~/.quicklisp/clhs-use-local.el"))
    (when (file-exists-p hs-docs)
      (load hs-docs t))))

(use-package slime-company
  :after (slime company)
  :config
  (setq slime-company-completion 'fuzzy))

(provide 'init-lisp)
