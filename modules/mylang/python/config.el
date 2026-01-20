;;; python
;; use ruff as formatter, remove default black 
(after! python
  (set-formatter! 'ruff :modes '(python-mode python-ts-mode)))

; TODO need to optimize and refactor it
;;(setq conda-anaconda-home (expand-file-name "/opt/workspace/miniconda3"))
;;(setq conda-env-home-directory (expand-file-name "/opt/workspace/miniconda3"))
;;                                        ;(setq python-pytest-executable "tox run -- pytest")
;;(setq python-pytest-executable "tox run --")
