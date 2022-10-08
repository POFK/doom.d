;;; workflow/chinese/config.el -*- lexical-binding: t; -*-
(define-key global-map (kbd "<f6>") 'pyim-create-2cchar-word-at-point)
(define-key global-map (kbd "<f7>") 'pyim-create-3cchar-word-at-point)
(define-key global-map (kbd "<f8>") 'pyim-create-4cchar-word-at-point)
(define-key global-map (kbd "<f9>") 'pyim-convert-string-at-point)
;;(setq pyim-page-tooltip 'pos-tip)
(setq pyim-backends '(pinyin-chars))

(setq-default pyim-english-input-switch-functions
              '(pyim-probe-dynamic-english))
(after! pyim
  (setq pyim-page-tooltip 'popup)
)

;; 使用搜索引擎提供的云输入法服务
(setq pyim-cloudim 'baidu)

;; 保存个人词条缓存－每天
(run-with-timer 0 (* 24 3600) 'pyim-dcache-save-caches)
