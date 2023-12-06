;;; -*- lexical-binding: t -*-

(defun my-value-to-mb (value)
  "Converts a value to megabytes"
  (* value 1024 1024))

(defun my-increase-gc-threshold ()
  (setq gc-cons-threshold (my-value-to-mb 50)))

(let ((tmp gc-cons-threshold))
  (my-increase-gc-threshold)
  (add-hook 'emacs-startup-hook (lambda () (setq gc-cons-threshold tmp))))

(dolist (mode '(menu-bar-mode scroll-bar-mode tool-bar-mode))
  (when (fboundp mode)
    (funcall mode -1)))

(setq inhibit-startup-message t)

;; disable package.el since we'll be using straight.el
(when (version<= "26" emacs-version)
  (setq package-enable-at-startup nil))
