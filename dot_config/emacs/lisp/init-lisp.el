;;; -*- lexical-binding: t -*-

(defun my-lisp-mode-common-hook ()
  (enable-paredit-mode)
  (rainbow-delimiters-mode-enable))

(use-package cider
  :hook
  ((cider-mode . my-lisp-mode-common-hook)
   (cider-repl-mode . (lambda ()
			(my-lisp-mode-common-hook)
			(local-set-key (kbd "C-c C-b") 'cider-repl-clear-buffer))))
  :config
  (add-to-list 'evil-emacs-state-modes 'cider-repl-mode)
  (add-to-list 'evil-emacs-state-modes 'cider-stacktrace-mode))

(use-package clojure-mode
  :hook (clojure-mode . my-lisp-mode-common-hook))

(use-package emacs-lisp-mode
  :ensure nil
  :hook (emacs-lisp-mode . my-lisp-mode-common-hook))

(use-package geiser-guile
  :hook (geiser-repl-mode . my-lisp-mode-common-hook))

(use-package paredit
  :bind (:map paredit-mode-map ("RET" . nil)))

(use-package scheme-mode
  :ensure nil
  :hook (scheme-mode . my-lisp-mode-common-hook))

(use-package slime
  :hook ((slime-mode . my-lisp-mode-common-hook)
         (slime-repl-mode . my-lisp-mode-common-hook))
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
