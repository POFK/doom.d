;;; workflow/secbrain/config.el -*- lexical-binding: t; -*-

(setq org-roam-capture-templates
      '(
	("d" "default" plain "%?"
     	 :target (file+head "%<%Y%m%d%H%M%S>-${slug}.org"
                        "#+filetags: :%<%Y>:\n\n#+title: ${title}\n"))
        ("i" "Idea" plain "* Topic\n\n%?\n* Related\n\n* Main idea\n\n* How to check\n"
	 :target (file+head "%<%Y%m%d%H%M%S>-${slug}.org"
			     "#+filetags: :%<%Y>:\n\n#+title: ${title}\n")
         :unnarrowed t
         :empty-lines 1)))

(setq org-roam-dailies-directory "daily/"
      org-roam-dailies-capture-templates
      '(
        ("d" "default" entry "* %?"
;;         "%[~/.doom.d/modules/workflow/secbrain/templates/daily.org]"
         :if-new (file+head "%<%Y-%m-%d>-diary.org"
                            "#+filetags: :diary:%<%Y>:\n\n#+title: %<%Y-%m-%d>\n %(f-read-text \"~/.doom.d/modules/workflow/secbrain/templates/daily.org\")"
                            )
        )))

;; roam-ui
(use-package! websocket
    :after org-roam)

(use-package! org-roam-ui
    :after org-roam ;; or :after org
;;         normally we'd recommend hooking orui after org-roam, but since org-roam does not have
;;         a hookable mode anymore, you're advised to pick something yourself
;;         if you don't care about startup time, use
;;  :hook (after-init . org-roam-ui-mode)
    :config
    (setq org-roam-ui-sync-theme t
          org-roam-ui-follow t
          org-roam-ui-update-on-save t
          org-roam-ui-open-on-start t))


(defun tim/org-roam-buffer-show (_)
  (if (and
       ;; Don't do anything if we're in the minibuffer or in the calendar
       (not (minibufferp))
       (not (derived-mode-p 'calendar-mode))
       ;; Show org-roam buffer iff the current buffer has a org-roam file
       (xor (org-roam-file-p) (eq 'visible (org-roam-buffer--visibility))))
      (org-roam-buffer-toggle)))
(add-hook 'window-buffer-change-functions 'tim/org-roam-buffer-show)
