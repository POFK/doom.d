;;; workflow/chinese/config.el -*- lexical-binding: t; -*-
(define-key global-map (kbd "<f6>") 'pyim-create-2cchar-word-at-point)
(define-key global-map (kbd "<f7>") 'pyim-create-3cchar-word-at-point)
(define-key global-map (kbd "<f8>") 'pyim-create-4cchar-word-at-point)
(define-key global-map (kbd "<f9>") 'pyim-convert-string-at-point)
(setq pyim-page-tooltip 'pos-tip)
(setq pyim-backends '(pinyin-chars))

(setq-default pyim-english-input-switch-functions
              '(pyim-probe-dynamic-english))
