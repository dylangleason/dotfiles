;;; -*- lexical-binding: t -*-

(when (treesit-available-p)
  (my-treesit-add-grammar 'c "https://github.com/tree-sitter/tree-sitter-c")
  (my-treesit-add-grammar 'cpp "https://github.com/tree-sitter/tree-sitter-cpp")
  (my-treesit-add-grammar 'cmake "https://github.com/uyha/tree-sitter-cmake"))

(defun my-cpp-indent-style ()
  `(((node-is "access_specifier") parent-bol 0)
    ((parent-is "declaration_list") parent-bol 0)
    ,@(alist-get 'bsd (c-ts-mode--indent-styles 'cpp))))

(defun my-c-mode-common-hook ()
  (setq-local indent-tabs-mode nil
              c-ts-mode-indent-offset 4)
  (flycheck-mode)
  (lsp-deferred))

(defun my-c-mode-hook ()
  (my-c-mode-common-hook)
  (setq-local c-ts-mode-indent-style 'bsd))

(defun my-c++-mode-hook ()
  (my-c-mode-common-hook)
  (setq-local c-ts-mode-indent-style #'my-cpp-indent-style))

(defun my-d-mode-hook ()
  (c-set-style "bsd")
  (setq-local c-basic-offset 4
	      compile-command "dmd")
  (my-c-mode-common-hook))

(use-package cmake-ts-mode
  :straight nil
  :init
  (add-to-list 'major-mode-remap-alist '(cmake-mode . cmake-ts-mode)))

(use-package c-ts-mode
  :straight nil
  :hook
  ((c-ts-mode . my-c-mode-hook)
   (c++-ts-mode . my-c++-mode-hook)
   (before-save . lsp-format-buffer))
  :init
  (with-eval-after-load 'lsp-mode
    (require 'dap-cpptools))
  (add-to-list 'major-mode-remap-alist '(c-mode . c-ts-mode))
  (add-to-list 'major-mode-remap-alist '(c++-mode . c++-ts-mode)))

(use-package d-mode
  :hook (d-mode . my-d-mode-hook))

(use-package company-dcd
  :after (company d-mode)
  :init
  (with-eval-after-load 'company-mode
    (add-to-list 'company-backends 'company-dcd)))

(provide 'init-c-cpp)
