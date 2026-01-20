(use-package! rime
  :custom
  (default-input-method "rime"))

(after! rime
  ;; 设置默认使用的输入方案
  ;; 雾凇拼音的主方案是 rime_ice
  (setq rime-default-candidate-count 9) ; 候选词数量

  (setq rime-show-candidate 'posframe) ; 使用悬浮窗显示候选词

  (setq rime-posframe-properties
        (list :background-color "#333333"
              :foreground-color "#dcdccc"
              :font "WenQuanYi Micro Hei Mono-14"
              :internal-border-width 10))
  )


