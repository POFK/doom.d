;;; workflow/gtd/config.el -*- lexical-binding: t; -*-

;; key mapping
(define-key global-map (kbd "C-c l") 'org-store-link)
(define-key global-map (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c c") 'org-capture)

;; some setting
(defun +txmao/gtd-init-directory-hook ()
  (setq txmao/gtd-dir (expand-file-name "gtd" org-directory))
  (setq txmao/gtd-inbox-file (expand-file-name "inbox.org" txmao/gtd-dir))
  (setq txmao/gtd-tasks-file (expand-file-name "tasks.org" txmao/gtd-dir))
  (setq txmao/gtd-read-later-file (expand-file-name "toread.org" txmao/gtd-dir))
)

(defun +txmao/gtd-init-keywards-hook ()
  (setq org-todo-keywords
        (quote ((sequence "TODO(t)" "InProgress(i)" "REVIEW(r)" "|" "DONE(d!/!)" "CANCELLED(c@/!)")
                (sequence "PLAN(p)" "|" "DONE(d!/!)" "CANCELLED(c@/!)")
                (sequence "MAYBE(m!/@)" "WAITING(w@/!)" "DELEGATED(e!)" "|" "CANCELLED(c@/!)")))
        org-todo-repeat-to-state "PLAN")

  (setq org-tag-alist '(("@onway" . ?w)
                        ("@office" . ?o)
                        ("@home" . ?h)
                        (:newline)
                        ("CANCELLED" . ?c)))

  (setq org-todo-keyword-faces
        `(("PLAN" . +org-todo-active)
          ("TODO" . +org-todo-active)
          ("InProgress" . +org-todo-active)
          ("REVIEW" . +org-todo-onhold)
          ("MAYBE" . +org-todo-onhold)
          ("WAITING" . +org-todo-onhold)
          ("DELEGATED" . +org-todo-onhold)
          ("CANCELLED" . +org-todo-cancel)
          ))

  (setq org-agenda-prefix-format
        '((agenda . " %i %-12:c%?-12t% s")
          (todo   . " ")
          (tags   . " %i %-12:c")
          (search . " %i %-12:c")))
)

(defun txmao/inbox-add-feature ()
  (org-agenda-set-tags)
  (org-agenda-priority)
  )

(defun txmao/org-process-inbox ()
  "Called in org-agenda-mode, processes all inbox items."
  (interactive)
  (org-agenda-bulk-mark-regexp "inbox:")
  ;;(org-agenda-filter-by-category "INBOX")
  (txmao/bulk-process-entries))

(defun txmao/org-agenda-process-inbox-item ()
  "Process a single item in the org-agenda."
  (org-with-wide-buffer
   (txmao/inbox-add-feature)
   ;;   (call-interactively 'jethro/my-org-agenda-set-effort)
   (org-agenda-refile nil nil t)))


(defun txmao/bulk-process-entries ()
  (if (not (null org-agenda-bulk-marked-entries))
      (let ((entries (reverse org-agenda-bulk-marked-entries))
            (processed 0)
            (skipped 0))
        (dolist (e entries)
          (let ((pos (text-property-any (point-min) (point-max) 'org-hd-marker e)))
            (if (not pos)
                (progn (message "Skipping removed entry at %s" e)
                       (cl-incf skipped))
              (goto-char pos)
              (let (org-loop-over-headlines-in-active-region) (funcall 'txmao/org-agenda-process-inbox-item))
              ;; `post-command-hook' is not run yet.  We make sure any
              ;; pending log note is processed.
              (when (or (memq 'org-add-log-note (default-value 'post-command-hook))
                        (memq 'org-add-log-note post-command-hook))
                (org-add-log-note))
              (cl-incf processed))))
        (org-agenda-redo)
        (unless org-agenda-persistent-marks (org-agenda-bulk-unmark-all))
        (message "Acted on %d entries%s%s"
                 processed
                 (if (= skipped 0)
                     ""
                   (format ", skipped %d (disappeared before their turn)"
                           skipped))
                 (if (not org-agenda-persistent-marks) "" " (kept marked)")))))



;; agenda view
(defun +txmao/gtd-init-agenda-view-hook ()
  (setq org-columns-default-format "%40ITEM(Task) %Effort(EE){:} %CLOCKSUM(Time Spent) %SCHEDULED(Scheduled) %DEADLINE(Deadline)")
  (setq org-agenda-custom-commands
        `(("g" "GTD"
           ((agenda ""
                    ((org-agenda-span 4)
                     (org-agenda-start-on-weekday nil)
                     (org-agenda-start-day "-3d")
                     (org-deadline-warning-days 60)))
            (tags "INBOX"
                  ((org-agenda-overriding-header "Inbox")
                   (org-agenda-files '(, (expand-file-name txmao/gtd-inbox-file)))
                   ))
            (todo "InProgress"
                  ((org-agenda-overriding-header "In Progress")
                   (org-agenda-files '(, (expand-file-name txmao/gtd-tasks-file)))
                   ))
            (todo "REVIEW"
                  ((org-agenda-overriding-header "Review")
                   (org-agenda-files '(, (expand-file-name txmao/gtd-tasks-file)))
                   ))
            (todo "TODO"
                  ((org-agenda-overriding-header "To-do")
                   (org-agenda-files '(, (expand-file-name txmao/gtd-tasks-file)))
                   ))
            (todo "DONE"
                  ((org-agenda-overriding-header "DONE")
                   (org-agenda-files '(, (expand-file-name txmao/gtd-tasks-file)))
                   ))
            (todo "PLAN"
                  ((org-agenda-overriding-header "Planning")
                   (org-agenda-files '(, (expand-file-name txmao/gtd-tasks-file)))
                   ))
            (todo "MAYBE"
                  ((org-agenda-overriding-header "Maybe")
                   (org-agenda-files '(, (expand-file-name txmao/gtd-tasks-file)))
                   ))
            ))
          ("i" "Read & write"
           ((tags "READ"
                  ((org-agenda-overriding-header "Read later")
                   (org-agenda-files '(, (expand-file-name txmao/gtd-read-later-file)))
                   ))
            ))
          )))

;; capturing
(defun capture-mails ())
(defun capture-website ())
(defun capture-rss ())
(defun capture-arxiv ())
(defun capture-note ())

;; some templates

;; refiling

;;--------------------------------------------------------------------------------


;; Here, the hook order is important, the last one is called first!
(add-hook! 'org-load-hook :append
           #'+txmao/gtd-init-agenda-view-hook
           #'+txmao/gtd-init-capture-templates-hook
           #'+txmao/gtd-init-keywards-hook
           #'+txmao/gtd-init-directory-hook
           )

(map! :map org-agenda-mode-map
      "<f5>" #'txmao/org-process-inbox)

;; (setq org-capture-templates
;;       `(("i" "Inbox" entry (file ,(expand-file-name "inbox.org" txmao/gtd-dir))
;;          ,(concat "* PLAN %?\n"
;;                   "/Entered on/ %u"))))

(defun +txmao/gtd-init-capture-templates-hook ()
  (add-to-list `org-capture-templates
               `("i" "Idea" entry (file ,(expand-file-name "inbox.org" txmao/gtd-dir))
                 ,(concat "* PLAN %?\n"
                          "/Entered on/ %u")))

  (add-to-list `org-capture-templates
               `("e" "Email" entry (file+headline ,(expand-file-name "inbox.org" txmao/gtd-dir) "Email")
                 "* Email: %?\nProcess mail from %:fromname on %:subject\nSCHEDULED:%t\nDEADLINE: %(org-insert-time-stamp (org-read-date nil t \"+2d\"))\n:PROPERTIES:\n:CREATED: %U\n:END:\n %a" :prepend t))
  )

(defun txmao/org-inbox-capture ()
  (interactive)
  "Capture a task in agenda mode."
  (org-capture nil "i"))


;; auto save file when quit agenda
;;(defmacro gtd-autosave-quit (fnc)
;;  "Return function that ignores its arguments and invokes FNC."
;;  `(lambda (&rest _rest)
;;     (funcall ,fnc)))
;;
;;(advice-add 'org-agenda-quit  :after (gtd-autosave-quit #'org-save-all-org-buffers))
