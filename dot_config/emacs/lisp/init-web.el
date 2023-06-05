;;; -*- lexical-binding: t -*-

(use-package company-web
  :demand t
  :config
  (eval-after-load 'company-mode
    (add-to-list 'company-backends 'company-web-html)))

(use-package js-comint)

(use-package js2-mode
  :hook (js2-mode . lsp-deferred)
  :bind (:map js2-mode-map
              ("C-x C-e" . js-send-last-sexp)
              ("C-x M-x" . js-send-last-sexp-and-go)
              ("C-c C-r" . js-send-region)
              ("C-c C-b" . js-send-buffer-and-go)
              ("C-c b" . js-send-buffer)
              ("C-c l" . js-load-file-and-go)
              ("C-c i" . js-doc-insert-function-doc))
  :mode "\\.js\\'"
  :init
  (setq indent-tabs-mode nil))

(use-package json-mode)

(use-package web-mode
  :mode "\\.html?\\'"
  :config
  (setq web-mode-css-indent-offset 2
        web-mode-code-indent-offset 2
        web-mode-markup-indent-offset 2
        web-mode-content-types-alist '(("jsx" . "\\.js[x]?\\'"))))

(provide 'init-web)
