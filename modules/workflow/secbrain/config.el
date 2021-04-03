;;; workflow/secbrain/config.el -*- lexical-binding: t; -*-

(use-package! org-roam-server
  :after org-roam
  :config
  (setq org-roam-server-host "127.0.0.1"
        org-roam-server-port 1080
        org-roam-server-authenticate nil
        org-roam-server-export-inline-images t
        org-roam-server-serve-files nil
        org-roam-server-served-file-extensions '("pdf" "mp4" "ogv")
        org-roam-server-network-poll t
        org-roam-server-network-arrows nil
        org-roam-server-network-label-truncate t
        org-roam-server-network-label-truncate-length 60
        org-roam-server-network-label-wrap-length 20))


(setq org-roam-capture-templates
      '(
        ("d" "default" plain (function org-roam-capture--get-point)
         "%?"
         :file-name "%<%Y%m%d%H%M%S>-${slug}"
         :head "#+title: ${title}\n#+roam_alias:\n\n")
        ("n" "Note" plain (function org-roam-capture--get-point)
               "* %? \n"
               :file-name "%<%Y%m%d%H%M%S>-${slug}"
               :head "#+title: ${title}\n#+roam_alias:\n#+roam_tags:\n#+roam_key: \n\n"
               :unnarrowed t
               :empty-lines 1)
        ("i" "Idea" plain (function org-roam-capture--get-point)
               "* Topic\n\n%?\n* Related\n\n* Main idea\n\n* How to check\n"
               :file-name "%<%Y%m%d%H%M%S>-${slug}"
               :head "#+title: ${title}\n#+roam_alias:\n#+roam_tags:\n#+roam_key: \n\n"
               :unnarrowed t
               :empty-lines 1)
               ))

(setq org-roam-dailies-directory "daily/"
      org-roam-dailies-capture-templates
      '(
        ("d" "default" plain (function org-roam-capture--get-point)
         "%[~/.doom.d/modules/workflow/secbrain/templates/daily.org]"
         :file-name "daily/%<%Y-%m-%d>-diary"
         :head "#+title: %<%Y-%m-%d>\n#+roam_tags: diary\n\n"
        )))

(org-roam-server-mode)
