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
  (add-hook 'prog-mode-hook #'my-line-numbers-mode))

(unless (display-graphic-p (selected-frame))
  (add-hook 'window-setup-hook #'transparency))

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

(setq history-length 25)
(savehist-mode 1)
(save-place-mode 1)

(setq use-dialog-box nil)

(global-auto-revert-mode 1)
(global-prettify-symbols-mode 1)
(prefer-coding-system 'utf-8)

(recentf-mode 1)

(global-set-key (kbd "C-c C-c") 'comment-or-uncomment-region)

;;; dired settings

(put 'dired-find-alternate-file 'disabled nil)

;; Sorting. See https://www.emacswiki.org/emacs/DiredSortDirectoriesFirst
(defun my-dired-sort ()
  "Sort dired listings with directories first."
  (save-excursion
    (let (buffer-read-only)
      (forward-line 2) ;; beyond dir. header
      (sort-regexp-fields t "^.*$" "[ ]*." (point) (point-max)))
    (set-buffer-modified-p nil)))

(defadvice dired-readin
  (after dired-after-updating-hook first () activate)
  "Sort dired listings with directories first before adding marks."
  (my-dired-sort))

;;; ediff settings

(setq ediff-diff-options "-w"
      ediff-split-window-function #'split-window-horizontally
      ediff-window-setup-function #'ediff-setup-windows-plain)

(defun my-command-line-diff (switch)
  (let ((file1 (pop command-line-args-left))
	(file2 (pop command-line-args-left)))
    (ediff file1 file2)))

;; usage: emacs -diff file1 file2
(add-to-list 'command-switch-alist '("diff" . my-command-line-diff))

;;; add tree-sitter AST shared object files to the load path

(defvar treesit-language-source-alist '())

(add-to-list 'load-path (concat user-emacs-directory "tree-sitter"))

(defun my-treesit-add-grammar (grammar src)
  "Add a treesitter language grammar given GRAMMAR and SRC."
  (add-to-list 'treesit-language-source-alist (list grammar src))
  (unless (treesit-language-available-p grammar)
    (treesit-install-language-grammar grammar)))

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

(defconst my-elisp-dir (concat user-emacs-directory "lisp"))

(add-to-list 'load-path my-elisp-dir)
(cl-loop for file in (directory-files my-elisp-dir)
	 and prev = nil then file
	 do (let ((curr (file-name-sans-extension file)))
	      (unless (or (not (string-match-p "\\.elc?$" file))
			  (string-equal curr (file-name-sans-extension prev)))
		(require (intern curr)))))
