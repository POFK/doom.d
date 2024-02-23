;;; workflow/chatgpt/config.el -*- lexical-binding: t; -*-

;; accept completion from copilot and fallback to company
(use-package! copilot
  :hook (prog-mode . copilot-mode)
  :bind (:map copilot-completion-map
	 ("C-c C-n" . 'copilot-accept-completion-by-word)
         ("C-<tab>" . 'copilot-accept-completion-by-word)
         ("<tab>" . 'copilot-accept-completion)
         ("TAB" . 'copilot-accept-completion)))

;; add proxy
(setq copilot-network-proxy '(:host "127.0.0.1" :port 7890))

;; ignore warning
(setq warning-suppress-log-types '((copilot)))
