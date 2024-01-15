;;; workflow/secbrain/config.el -*- lexical-binding: t; -*-

(setq org-roam-capture-templates
      '(
	("d" "default" plain "%?"
     	 :target (file+head "%<%Y%m%d%H%M%S>-${slug}.org"
                        "#+filetags: :%<%Y>:\n\n#+title: ${title}\n"))
	("b" "blog" plain "%?"
     	 :target (file+head "%<%Y%m%d%H%M%S>-${slug}.org"
                            "#+title: ${title}\n\n#+filetags: \n#+date: %<%Y-%m-%d>\n#+EXPORT_FILE_NAME: ${id}\n%[~/.doom.d/modules/workflow/secbrain/templates/post.org]"))
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
                            "#+filetags: :diary:%<%Y>:\n\n#+title: %<%Y-%m-%d>\n %[~/.doom.d/modules/workflow/secbrain/templates/daily.org]"
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

;; mu4e
(add-to-list 'load-path "/usr/share/emacs/site-lisp/mu4e")

;; mu4e-views
;; (use-package! mu4e-views
;;   :after mu4e
;;   :config
;;   (setq mu4e-views-completion-method 'ivy)
;;   (setq mu4e-views-default-view-method "html")
;;   (setq mu4e-views-next-previous-message-behaviour 'stick-to-current-window) ;; when pressing n and p stay in the current window
;;   (setq mu4e-views-mu4e-html-email-header-style
;;         "<style type=\"text/css\">
;; .mu4e-mu4e-views-mail-headers { font-family: sans-serif; font-size: 10pt; margin-bottom: 30px; padding-bottom: 10px; border-bottom: 1px solid #ccc; color: #000;}
;; .mu4e-mu4e-views-header-row { display:block; padding: 1px 0 1px 0; }
;; .mu4e-mu4e-views-mail-header { display: inline-block; text-transform: capitalize; font-weight: bold; }
;; .mu4e-mu4e-views-header-content { display: inline-block; padding-right: 8px; }
;; .mu4e-mu4e-views-email { display: inline-block; padding-right: 8px; }
;; .mu4e-mu4e-views-attachment { display: inline-block; padding-right: 8px; }
;; </style>"
;;         )

;;   (add-hook! mu4e-headers-mode
;;     (mu4e-views-mu4e-use-view-msg-method "html")) ;; select the default

;;   (map! :map mu4e-headers-mode-map
;;         :n "M-b" #'mu4e-views-cursor-msg-view-window-up
;;         :n "M-f" #'mu4e-views-cursor-msg-view-window-down
;;         :localleader
;;         :desc "Message action"        "a"   #'mu4e-views-mu4e-view-action
;;         :desc "Scoll message down"    "b"   #'mu4e-views-cursor-msg-view-window-up
;;         :desc "Scoll message up"      "f"   #'mu4e-views-cursor-msg-view-window-down
;;         :desc "Open attachment"       "o"   #'mu4e-views-mu4e-view-open-attachment
;;         :desc "Save attachment"       "s"   #'mu4e-views-mu4e-view-save-attachment
;;         :desc "Save all attachments"  "S"   #'mu4e-views-mu4e-view-save-all-attachments
;;         :desc "Set view method"       "v"   #'mu4e-views-mu4e-select-view-msg-method)) ;; select viewing method)


;; ;; Evil bindings for xwidget webkit browsers
;; (map! :map xwidget-webkit-mode-map
;;       :n "Z Z" #'quit-window
;;       :n "gr"  #'xwidget-webkit-reload
;;       :n "y"   #'xwidget-webkit-copy-selection-as-kill
;;       :n "s-c" #'xwidget-webkit-copy-selection-as-kill
;;       :n "t"   #'xwidget-webkit-browse-url
;;       :n "TAB" #'xwidget-webkit-forward
;;       :n "C-o" #'xwidget-webkit-back
;;       :n "G"   #'xwidget-webkit-scroll-bottom
;;       :n "gg"  #'xwidget-webkit-scroll-top
;;       :n "C-b" #'xwidget-webkit-scroll-down
;;       :n "C-f" #'xwidget-webkit-scroll-up
;;       :n "M-=" #'xwidget-webkit-zoom-in
;;       :n "M--" #'xwidget-webkit-zoom-out
;;       :n "k"   #'xwidget-webkit-scroll-down-line
;;       :n "j"   #'xwidget-webkit-scroll-up-line)
