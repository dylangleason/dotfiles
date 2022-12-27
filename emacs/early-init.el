;;; -*- lexical-binding: t -*-

(let ((tmp gc-cons-threshold))
  (setq gc-cons-threshold (* 20 1024 1024))
  (add-hook 'emacs-startup-hook (lambda () (setq gc-cons-threshold tmp))))

(dolist (mode '(menu-bar-mode scroll-bar-mode tool-bar-mode))
  (when (fboundp mode)
    (funcall mode -1)))

(setq inhibit-startup-message t)

(message "Early init loaded!")
