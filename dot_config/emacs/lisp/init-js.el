;; -*- lexical-binding: t; -*-

(when (treesit-available-p)
  (my-treesit-add-grammar
   'javascript
   "https://github.com/tree-sitter/tree-sitter-javascript")
  (my-treesit-add-grammar
   'tsx
   "https://github.com/tree-sitter/tree-sitter-typescript" "v0.23.2" "tsx/src")
  (my-treesit-add-grammar
   'typescript
   "https://github.com/tree-sitter/tree-sitter-typescript" "v0.23.2" "typescript/src"))

(use-package js-comint)

(use-package js
  :straight nil
  :hook
  ((js-mode . my-js-mode-hook)
   (js-ts-mode . my-js-mode-hook)
   (before-save . lsp-format-buffer))
  :init
  (defun my-js-bind-local-keymap (key-map)
    (bind-key "C-x C-e" #'js-send-last-sexp key-map)
    (bind-key "C-c C-r" #'js-send-send-region key-map)
    (bind-key "C-c C-b" #'js-send-buffer key-map))

  (defun my-js-mode-hook ()
    (setq-local indent-tabs-mode nil)
    (setq-local tab-width 2)
    (my-js-bind-local-keymap (current-local-map))
    (flycheck-mode)
    (lsp-deferred))

  (when (treesit-language-available-p 'javascript)
    (add-to-list 'major-mode-remap-alist '(javascript-mode . js-ts-mode))
    (add-to-list 'major-mode-remap-alist '(js-mode . js-ts-mode))))

(use-package typescript-ts-mode
  :if (treesit-language-available-p 'typescript)
  :straight nil
  :mode "\\.ts[x]?\\'"
  :hook
  ((typescript-ts-mode . my-typescript-mode-hook)
   (before-save . lsp-format-buffer))
  :init
  (defun my-typescript-mode-hook ()
    (setq-local typescript-indent-level 2)
    (flycheck-mode)
    (lsp-deferred)))

(provide 'init-js)
