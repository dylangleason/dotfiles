;;; -*- lexical-binding: t -*-

;;; Basic configuration

(defun my-line-numbers-mode ()
  (display-line-numbers-mode)
  (setq display-line-numbers-type 'visual))

(defun transparency ()
  (set-face-background 'default "unspecified-bg" (selected-frame)))

(when (version< emacs-version "27")
  (load (concat user-emacs-directory) "early-init"))

(unless (version< emacs-version "26")
  (add-hook 'prog-mode-hook 'my-line-numbers-mode))

(unless (display-graphic-p (selected-frame))
  (add-hook 'window-setup-hook 'transparency))

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

(global-set-key (kbd "C-c C-c") 'comment-or-uncomment-region)

;;; Manage packages using straight.el instead of package.el

(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 6))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(setq straight-use-package-by-default t)
(straight-use-package 'use-package)

;;; Require additional elisp packages in the lisp directory

(add-to-list 'load-path (concat user-emacs-directory "lisp"))

(cl-loop for file in (directory-files (concat user-emacs-directory "lisp"))
	 and prev = nil then file
	 do (let ((curr (file-name-sans-extension file)))
	      (unless (or (string-equal curr ".")
			  (string-equal curr "..")
			  (string-suffix-p "~undo-tree~" file)
			  (string-equal curr (file-name-sans-extension prev)))
		(require (intern curr)))))
