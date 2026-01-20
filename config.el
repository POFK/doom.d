;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

(setq user-full-name "TX Mao"
      user-mail-address "mtianxiang@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))

(setq doom-font (font-spec :family "monospace" :size 32 :weight 'semi-light)
      doom-variable-pitch-font (font-spec :family "sans" :size 32))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-palenight)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
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
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(setq doom-leader-key ",")
(setq doom-localleader-key ",")


;;;============================================================
;;; org and roam
(setq org-directory "/tank/data/dataset/org/")
(setq org-agenda-files '("/tank/data/dataset/org/gtd"))
(setq org-roam-directory "/tank/data/dataset/org/roam")

                                        ; insert css for org html export
                                        ; TODO the css file path should be put into the nix flake
                                        ; TODO move this function to module/lang
(defun my-org-inline-css-hook (exporter)
  "Insert custom inline css"
  (when (eq exporter 'html)
    (let* ((dir (ignore-errors (file-name-directory (buffer-file-name))))
           (path (concat dir "customize.css"))
           (homestyle (or (null dir) (null (file-exists-p path))))
           (final (if homestyle "/tank/data/dataset/org/css/customize.css" path))) ;; <- set your own style file path
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

(setq org-publish-project-alist
      '(("roam"
         :base-directory "/tank/data/dataset/org/roam"
         :publishing-function org-html-publish-to-html
         :publishing-directory "~/Desktop/public"
         :section-numbers nil
         :table-of-contents nil
         :recursive t
         :auto-sitemap t
         :makeindex t
         :style "<link rel=\"stylesheet\"
               href=\"/tank/data/dataset/org/css/customize.css\"
               type=\"text/css\"/>")))

(setq org-element-use-cache nil)

                                        ; TODO the chrome, zathura... need to fix in nix flake?
(after! org
  (add-to-list 'org-file-apps
               '("\\.pdf\\'" . (lambda (file link)
                                 (call-process "zathura" nil 0 nil "--mode" "fullscreen" file))))
  (add-to-list 'org-file-apps
               '("\\.x?html?\\'" . "google-chrome %s"))
  (add-to-list 'org-link-abbrev-alist
               '("arxiv" . "http://dev.pangu.datalab:7788/arxiv/%s"))
  )


;;(setq bibtex-completion-pdf-open-function (lambda (file)
;;                                            (call-process "zathura" nil 0 nil "--mode" "fullscreen" file)))



;;;============================================================
;;; pyin
                                        ; TODO move it to chinese
                                        ; (setq pyim-page-tooltip 'popup)

;;;============================================================
;;; email
                                        ; gmail by mu4e
                                        ; TODO comment out it
                                        ;(set-email-account!
                                        ; "gmail"
                                        ; '((mu4e-sent-folder       . "/[Gmail]/Sent Mail")
                                        ;   (mu4e-trash-folder      . "/[Gmail]/Trash")
                                        ;   (smtpmail-smtp-user     . "mtianxiang@gmail.com"))
                                        ; t)
                                        ;(after! mu4e
                                        ;  (setq mu4e-get-mail-command "proxychains -q mbsync gmail"
                                        ;        ;; get emails and index every 1 minutes
                                        ;        mu4e-update-interval 60
                                        ;        ;; send emails with format=flowed
                                        ;        mu4e-compose-format-flowed t
                                        ;        ;; no need to run cleanup after indexing for gmail
                                        ;        mu4e-index-cleanup nil
                                        ;        mu4e-index-lazy-check t
                                        ;        ;; more sensible date format
                                        ;        mu4e-headers-date-format "%d.%m.%y")
                                        ;  (setq sendmail-program (executable-find "msmtp")
                                        ;        send-mail-function #'smtpmail-send-it
                                        ;        message-sendmail-f-is-evil t
                                        ;        message-sendmail-extra-arguments '("--read-envelope-from")
                                        ;        message-send-mail-function #'message-send-mail-with-sendmail)
                                        ;  )



;;;============================================================
;;; golang
                                        ; TODO check it and why the lang:golang is not worked well?
;; golang

;;(add-to-list 'load-path "/home/worker/go/bin")
;;(autoload 'go-mode "go-mode" nil t)
;;(add-to-list 'auto-mode-alist '("\\.go\\'" . go-mode))
;;                                        ;(add-hook 'go-mode-hook #'format-all-mode)


;;;============================================================
;;; others and need to check

;;; for racket lisp
                                        ;(use-package! racket-mode
                                        ;  :mode "\\.rkt\\'"  ; give it precedence over :lang scheme
                                        ;  :config
                                        ;  (set-formatter! 'raco-fmt '("raco" "fmt" "--width" "80") :modes '(racket-mode))
                                        ;  )
                                        ;
;;; set default browser
                                        ;(setq browse-url-browser-function 'browse-url-generic
                                        ;      browse-url-generic-program "google-chrome")
                                        ;
                                        ;
;;; set for plantuml
                                        ;(setq plantuml-executable-path "/usr/bin/plantuml")
                                        ;(setq plantuml-default-exec-mode 'executable)



;;;============================================================
;;; chinese + rime

(setq 
 rime-user-data-dir "~/.cache/emacs/rime"
 rime-share-data-dir "~/.config/rime"
 )
