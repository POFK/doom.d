;; -*- no-byte-compile: t; -*-
;;; workflow/chatgpt/packages.el

;; (package! pangu :recipe (:host github :repo "POFK/pangu.el" :files ("*.el")))

(package! pangu 
  :recipe (:host nil :repo "http://git.pangu.datalab/POFK/pangu.el.git" :files ("*.el")))
