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

;;; Initialize packages

(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package)
  (setq use-package-always-defer t)
  (setq use-package-always-ensure t))

(add-to-list 'load-path (concat user-emacs-directory "lisp"))

;;; Require additional elisp packages in the lisp directory

(cl-loop for file in (directory-files (concat user-emacs-directory "lisp"))
	 and prev = nil then file
	 do (let ((curr (file-name-sans-extension file)))
	      (unless (or (string-equal curr ".")
			  (string-equal curr "..")
			  (string-suffix-p "~undo-tree~" file)
			  (string-equal curr (file-name-sans-extension prev)))
		(require (intern curr)))))
