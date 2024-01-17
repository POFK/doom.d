;;; workflow/chatgpt/config.el -*- lexical-binding: t; -*-

(use-package! chatgpt
  :defer t
  :config
  (unless (boundp 'python-interpreter)
    (defvaralias 'python-interpreter 'python-shell-interpreter))
  (setq chatgpt-repo-path (expand-file-name "straight/repos/ChatGPT.el/" doom-local-dir))
  (set-popup-rule! (regexp-quote "*ChatGPT*")
    :side 'bottom :size .5 :ttl nil :quit t :modeline nil)
  :bind ("C-c q" . chatgpt-query))


(setq chatgpt-query-format-string-map '(
                                        ;; ChatGPT.el defaults
                                        ("doc" . "Please write the documentation for the following function.\n\n%s")
                                        ("bug" . "There is a bug in the following function, please help me fix it.\n\n%s")
                                        ("understand" . "What does the following function do?\n\n%s")
                                        ("improve" . "Please improve the following code.\n\n%s")
                                        ;; your new prompt
                                        ("golang-gen" . "你是一个golang工程师，我会给出函数名和注释，你根据注释添加相应的内容使其完成注释中要求的功能，最后给出相应的测试程序。在生成的程序中，你要保留我添加的注释。下面我给出我的第一个需求信息： \n\n%s")))

;; accept completion from copilot and fallback to company
(use-package! copilot
  :hook (prog-mode . copilot-mode)
  :bind (("C-c C-n" . 'copilot-accept-completion-by-word)
         ("C-<tab>" . 'copilot-accept-completion-by-word)
         :map copilot-completion-map
         ("<tab>" . 'copilot-accept-completion)
         ("TAB" . 'copilot-accept-completion)))

;; add proxy
(setq copilot-network-proxy '(:host "127.0.0.1" :port 7890))

;; ignore warning
(setq warning-suppress-log-types '((copilot)))
