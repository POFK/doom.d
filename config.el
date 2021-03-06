;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "TX Mao"
      user-mail-address "mtianxiang@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;;(setq doom-font (font-spec :family "monospace" :size 20 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "sans" :size 21))

(setq doom-font (font-spec :family "monospace" :size 32 :weight 'semi-light)
      doom-variable-pitch-font (font-spec :family "sans" :size 32))


;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;;(setq doom-theme 'doom-one)
(setq doom-theme 'doom-palenight)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;;(setq doom-leader-key "SPC")
(setq evil-snipe-override-evil-repeat-keys nil)
(setq doom-leader-key ",")
(setq doom-localleader-key ",")

(setq org-roam-directory "~/org/roam")

(if (eq initial-window-system 'x)                 ; if started by emacs command or desktop file
    (toggle-frame-maximized)
  (toggle-frame-fullscreen))

(setq evil-vsplit-window-right t
      evil-split-window-below t)
(defadvice! prompt-for-buffer (&rest _)
  :after '(evil-window-split evil-window-vsplit)
  (+ivy/switch-buffer))
(setq +ivy-buffer-preview t)

;;(add-to-list 'org-link-abbrev-alist
;;             '("arxiv" . "http://nexus.storage.datalab/repository/arxivproxy/%s.pdf"))


;; emacs TCP server
;;(setq server-use-tcp t
;;      server-host "127.0.0.1"
;;      server-port 31415)

;;(server-start)

;; insert css for org html export
(defun my-org-inline-css-hook (exporter)
  "Insert custom inline css"
  (when (eq exporter 'html)
    (let* ((dir (ignore-errors (file-name-directory (buffer-file-name))))
           (path (concat dir "customize.css"))
           (homestyle (or (null dir) (null (file-exists-p path))))
           (final (if homestyle "~/org/css/customize.css" path))) ;; <- set your own style file path
      (setq org-html-head-include-default-style nil)
      (setq org-html-head (concat
                           "<style type=\"text/css\">\n"
                           "<!--/*--><![CDATA[/*><!--*/\n"
                           (with-temp-buffer
                             (insert-file-contents final)
                             (buffer-string))
                           "/*]]>*/-->\n"
                           "</style>\n")))))

(add-hook 'org-export-before-processing-hook 'my-org-inline-css-hook)
;;(set-background-color nil)

;; add setting for pushing org
(setq org-publish-project-alist
     '(("roam"
        :base-directory "~/org/roam"
        :publishing-function org-html-publish-to-html
        :publishing-directory "~/Desktop/public"
        :section-numbers nil
        :table-of-contents nil
        :recursive t
        :auto-sitemap t
        :makeindex t
        :style "<link rel=\"stylesheet\"
               href=\"~/org/css/customize.css\"
               type=\"text/css\"/>")))

(setq org-element-use-cache nil)

(setq pyim-page-tooltip 'popup)

;; gmail by mu4e
(set-email-account!
 "gmail"
 '((mu4e-sent-folder       . "/[Gmail]/Sent Mail")
   (mu4e-trash-folder      . "/[Gmail]/Trash")
   (smtpmail-smtp-user     . "mtianxiang@gmail.com"))
 t)
(after! mu4e
  (setq mu4e-get-mail-command "proxychains -q mbsync gmail"
        ;; get emails and index every 1 minutes
        mu4e-update-interval 60
	;; send emails with format=flowed
	mu4e-compose-format-flowed t
	;; no need to run cleanup after indexing for gmail
	mu4e-index-cleanup nil
	mu4e-index-lazy-check t
        ;; more sensible date format
        mu4e-headers-date-format "%d.%m.%y")
  (setq sendmail-program (executable-find "msmtp")
        send-mail-function #'smtpmail-send-it
        message-sendmail-f-is-evil t
        message-sendmail-extra-arguments '("--read-envelope-from")
        message-send-mail-function #'message-send-mail-with-sendmail)
  )


;; python
(setq conda-anaconda-home (expand-file-name "/opt/conda"))
(setq conda-env-home-directory (expand-file-name "/opt/conda"))
