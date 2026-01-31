;;; config.el --- Description -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2026 TX Mao
;;
;; Author: TX Mao <mtianxiang@gmail.com>
;; Maintainer: TX Mao <mtianxiang@gmail.com>
;; Created: January 30, 2026
;; Modified: January 30, 2026
;; Version: 0.0.1
;; Keywords: abbrev bib c calendar comm convenience data docs emulations extensions faces files frames games hardware help hypermedia i18n internal languages lisp local maint mail matching mouse multimedia news outlines processes terminals tex text tools unix vc wp
;; Homepage: https://github.com/worker/config
;; Package-Requires: ((emacs "24.3"))
;;
;; This file is not part of GNU Emacs.
;;
;;; Commentary:
;;
;;  Description
;;
;;; Code:

(use-package! typespec-ts-mode
  :mode "\\.tsp\\'"
  :config
  ;; 如果你想在进入该模式时自动开启 LSP
  (add-hook 'typespec-ts-mode-hook #'lsp-deferred))

;; 配置 LSP Mode 识别 tsp-server
(after! lsp-mode
  (add-to-list 'lsp-language-id-configuration '(typespec-ts-mode . "typespec"))
  (lsp-register-client
   (make-lsp-client :new-connection (lsp-stdio-connection '("tsp-server" "--stdio"))
                    :major-modes '(typespec-ts-mode)
                    :server-id 'tsp-server)))

(after! treesit
  (add-to-list 'treesit-language-source-alist
               '(typespec "https://github.com/happenslol/tree-sitter-typespec")))

(provide 'config)
;;; config.el ends here
