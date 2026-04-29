;; -*- lexical-binding: t; -*-

(when (treesit-available-p)
  (my-treesit-add-grammar 'json "https://github.com/tree-sitter/tree-sitter-json"))

(use-package css-mode
  :straight nil
  :init
  (setq indent-tabs-mode nil))

(use-package json-ts-mode
  :if (treesit-language-available-p 'json)
  :straight nil)

(use-package json-mode
  :unless (treesit-language-available-p 'json))

(use-package restclient
  :demand t
  :init
  (add-to-list 'auto-mode-alist '("\\.http\\'" . restclient-mode)))

(use-package simple-httpd
  :straight nil
  :config
  (setq httpd-port 7070))

(use-package company-web
  :demand t
  :init
  (with-eval-after-load 'company-mode
    (add-to-list 'company-backends 'company-web-html)))

(use-package web-mode
  :mode
  (("\\.html?\\'" . web-mode)
   ("\\.svg\\'" . web-mode))
  :config
  (setq web-mode-css-indent-offset 2
        web-mode-code-indent-offset 2
        web-mode-markup-indent-offset 2))

(use-package w3m)

(provide 'init-web)
