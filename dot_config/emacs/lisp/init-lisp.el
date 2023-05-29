;;; -*- lexical-binding: t -*-

(use-package cider
  :hook
  ((cider-mode . enable-paredit-mode)
   (cider-repl-mode . (lambda ()
			(enable-paredit-mode)
			(local-set-key (kbd "C-c C-b") 'cider-repl-clear-buffer))))
  :config
  (add-to-list 'evil-emacs-state-modes 'cider-repl-mode)
  (add-to-list 'evil-emacs-state-modes 'cider-stacktrace-mode))

(use-package clojure-mode
  :hook (clojure-mode . enable-paredit-mode))

(use-package emacs-lisp-mode
  :straight nil
  :hook (emacs-lisp-mode . enable-paredit-mode))

(use-package geiser-guile
  :hook (geiser-repl-mode . enable-paredit-mode))

(use-package paredit
  :bind (:map paredit-mode-map ("RET" . nil)))

(use-package scheme-mode
  :straight nil
  :hook (scheme-mode . enable-paredit-mode))

(use-package slime
  :hook ((slime-mode . enable-paredit-mode)
         (slime-repl-mode . enable-paredit-mode))
  :init
  (setq inferior-lisp-program "sbcl"
        slime-protocol-version 'ignore)
  :config
  (slime-setup '(slime-repl
                 slime-asdf
                 slime-fancy
                 slime-company)))

(use-package slime-company
  :after (slime company)
  :config
  (setq slime-company-completion 'fuzzy))

(provide 'init-lisp)
