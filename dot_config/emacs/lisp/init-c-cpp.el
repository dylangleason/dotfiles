;;; -*- lexical-binding: t -*-

(defun my-c-mode-common-hook ()
  (setq-local indent-tabs-mode nil)
  (flycheck-mode)
  (lsp-deferred))

(add-hook 'c-mode-common-hook 'my-c-mode-common-hook)

(setq my-c-style-alist '((c-basic-offset . 4)))
(c-add-style "my-c-style" (cons "k&r" my-c-style-alist))
(c-add-style "my-c++-style" (cons "stroustrup" my-c-style-alist))
(c-add-style "my-d-style" (cons "bsd" my-c-style-alist))

(defun my-c-mode-hook ()
  (c-set-style "my-c-style"))

(defun my-c++-mode-hook ()
  (c-set-style "my-c++-style"))

(defun my-d-mode-hook ()
  (c-set-style "my-d-style")
  (company-dcd-mode))

(use-package c-mode
  :ensure nil
  :hook (c-mode . my-c-mode-hook))

(use-package c++-mode
  :ensure nil
  :hook (c++-mode . my-c++-mode-hook))

(use-package company-dcd
  :after (company d-mode))

(use-package d-mode
  :hook (d-mode . my-d-mode-hook))

(provide 'init-c-cpp)
