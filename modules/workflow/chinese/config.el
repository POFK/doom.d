;;; workflow/chinese/config.el -*- lexical-binding: t; -*-

(require 'popup)

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

;; 显示 5 个候选词。
(setq pyim-page-length 5)

;; 设置 pyim 默认使用的输入法策略，我使用全拼。
(pyim-default-scheme 'quanpin)

;; 开启代码搜索中文功能（比如拼音，五笔码等）
(pyim-isearch-mode 1)

;; 保存个人词条缓存－每天
(run-with-timer 0 (* 24 3600) 'pyim-dcache-save-caches)

;; 自动保存词频，用于统计个人习惯(来自 ChatGPT, not checked)
(setq pyim-enable-words-predict 'personal)
(setq pyim-dcache-directory "/fasttank/workspace/cache/pyim/dcache/")
;;(setq pyim-dcache-directory "/config/.doom.d/pyim/dcache/")
(setq pyim-dcache-auto-save-interval 3600)

;; 设置半角标点
(setq-default pyim-punctuation-translate-p '(auto))
;;(setq-default pyim-punctuation-translate-p '(no)) ;; 半角字符
;;(setq-default pyim-punctuation-translate-p '(yes)) ;; 全角字符

(setq pyim-indicator-list (list #'my-pyim-indicator-with-cursor-color #'pyim-indicator-with-modeline))

(defun my-pyim-indicator-with-cursor-color (input-method chinese-input-p)
  (if (not (equal input-method "pyim"))
      (progn
        ;; 用户在这里定义 pyim 未激活时的光标颜色设置语句
        (set-cursor-color "red"))
    (if chinese-input-p
        (progn
          ;; 用户在这里定义 pyim 输入中文时的光标颜色设置语句
          (set-cursor-color "green"))
      ;; 用户在这里定义 pyim 输入英文时的光标颜色设置语句
      (set-cursor-color "blue"))))
