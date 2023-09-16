;;; -*- lexical-binding: t -*-

(unless (version< emacs-version "29")
  (my-treesit-add-grammar 'c "https://github.com/tree-sitter/tree-sitter-c")
  (my-treesit-add-grammar 'cpp "https://github.com/tree-sitter/tree-sitter-cpp")
  (my-treesit-add-grammar 'cmake "https://github.com/uyha/tree-sitter-cmake"))

(defun my-cpp-indent-style ()
  `(((node-is "access_specifier") parent-bol 0)
    ((parent-is "declaration_list") parent-bol 0)
    ,@(alist-get 'bsd (c-ts-mode--indent-styles 'cpp))))

(defun my-c-mode-common-hook ()
  (setq-local indent-tabs-mode nil)
  (flycheck-mode)
  (lsp-deferred))

(defun my-c-mode-hook ()
  (setq-local c-ts-mode-indent-offset 4)
  (my-c-mode-common-hook))

(defun my-d-mode-hook ()
  (c-set-style "bsd")
  (setq-local c-basic-offset 4
	      compile-command "dmd")
  (my-c-mode-common-hook))

(use-package c-ts-mode
  :if (treesit-language-available-p 'c)
  :straight nil
  :custom (c-ts-mode-indent-style 'bsd)
  :hook
  (c-ts-mode . my-c-mode-hook)
  :init
  (add-to-list 'major-mode-remap-alist '(c-mode . c-ts-mode)))

(use-package c++-ts-mode
  :straight nil
  :if (treesit-language-available-p 'cpp)
  :custom (c-ts-mode-indent-style #'my-cpp-indent-style)
  :hook
  (c++-ts-mode . my-c-mode-hook)
  :init
  (add-to-list 'major-mode-remap-alist '(c++-mode . c++-ts-mode)))

(use-package company-dcd
  :after (company d-mode)
  :config
  (eval-after-load 'company-mode
    (add-to-list 'company-backends 'company-dcd)))

(use-package d-mode
  :hook
  (d-mode . my-d-mode-hook)
  :straight
  (d-mode :type git
	  :host github
	  :repo "Emacs-D-Mode-Maintainers/Emacs-D-Mode"))

(provide 'init-c-cpp)
