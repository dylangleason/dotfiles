;;; -*- lexical-binding: t -*-

(when (treesit-available-p)
  (my-treesit-add-grammar 'python "https://github.com/tree-sitter/tree-sitter-python"))

(use-package blacken
  :after (:any (python-mode python-ts-mode)))

(use-package lsp-pyright)

(use-package python
  :straight nil
  :hook
  ((python-mode . my-python-mode-hook)
   (python-ts-mode . my-python-mode-hook)
   (before-save . lsp-format-buffer))
  :init
  (defun my-python-mode-hook ()
    (add-to-list 'interpreter-mode-alist (cons "python" major-mode))
    (blacken-mode)
    (flycheck-mode)
    (lsp-deferred))

  (setq python-shell-interpreter
        "ipython"
        python-shell-interpreter-args
        "--simple-prompt -c exec('__import__(\\'readline\\')') -i")

  (when (treesit-language-available-p 'python)
    (add-to-list 'major-mode-remap-alist '(python-mode . python-ts-mode))))

(use-package python-pytest)

(provide 'init-python)
