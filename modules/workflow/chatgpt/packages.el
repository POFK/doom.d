;; -*- no-byte-compile: t; -*-
;;; workflow/chatgpt/packages.el

(package! chatgpt
  :recipe (:host github :repo "joshcho/ChatGPT.el" :files ("dist" "*.el")))

(package! copilot
  :recipe (:host github :repo "zerolfx/copilot.el" :files ("*.el" "dist")))
