;;; workflow/refs/config.el -*- lexical-binding: t; -*-

(use-package! org-roam-bibtex
  :after org-roam
  :load-path "/tank/data/dataset/org/refs/lib/library.bib" ;Modify with your own path
  :hook (org-roam-mode . org-roam-bibtex-mode)
  :bind (:map org-mode-map
              (("C-c n a" . orb-note-actions))))


(use-package! helm-bibtex
  :after org
  :init
                                        ; blah blah
  :config
  )

(setq bibtex-format-citation-functions
      '((org-mode . (lambda (x) (insert (concat
                                         "\\cite{"
                                         (mapconcat 'identity x ",")
                                         "}")) ""))))
(setq
 bibtex-completion-pdf-field "file"
 bibtex-completion-bibliography "/tank/data/dataset/org/refs/lib/library.bib"
 biblio-download-directory "/tank/data/dataset/org/refs/files/"
 bibtex-completion-library-path '("/tank/data/dataset/org/refs/files/")
 bibtex-completion-notes-path "/tank/data/dataset/org/refs/notes"
 )

(setq bibtex-completion-format-citation-functions
      '((org-mode      . bibtex-completion-format-citation-org-link-to-PDF)
        (latex-mode    . bibtex-completion-format-citation-cite)
        (markdown-mode . bibtex-completion-format-citation-pandoc-citeproc)
        (default       . bibtex-completion-format-citation-default)))

(setq bibtex-completion-additional-search-fields '(tags))

(use-package! org-ref
  :after org
  :init
                                        ; code to run before loading org-ref
  :config
  (setq reftex-default-bibliography '("/tank/data/dataset/org/refs/lib/library.bib")
        org-ref-notes-directory "/tank/data/dataset/org/refs/notes/"
        org-ref-default-bibliography '("/tank/data/dataset/org/refs/lib/library.bib")
        org-ref-pdf-directory "/tank/data/dataset/org/refs/files/")
  )

(map! :leader "f a"#'helm-bibtex)  ; "find article" : opens up helm bibtex for search.
(map! :leader "i l"#'doi-utils-update-bibtex-entry-from-doi)

;; set for compile latex with bibtex
(setq org-latex-pdf-process
      '("latexmk -pdflatex='pdflatex -interaction nonstopmode' -pdf -bibtex -f %f"))

(setq orb-templates
      '(("r" "ref" plain (function org-roam-capture--get-point) ""
         :file-name "${citekey}"
         :head "#+TITLE: ${citekey}: ${title}\n#+ROAM_KEY: ${ref}\n" ; <--
         :unnarrowed t)))
(setq orb-preformat-keywords   '(("citekey" . "=key=") "title" "url" "file" "author-or-editor" "keywords"))

(setq orb-templates
      '(("n" "ref+noter" plain (function org-roam-capture--get-point)
         ""
         :file-name "${slug}"
         :head "#+TITLE: ${citekey}: ${title}\n#+ROAM_KEY: ${ref}\n#+ROAM_TAGS:
- tags ::
- keywords :: ${keywords}
\* ${title}
:PROPERTIES:
:Custom_ID: ${citekey}
:URL: ${url}
:AUTHOR: ${author-or-editor}
:NOTER_DOCUMENT: %(orb-process-file-field \"${citekey}\")
:NOTER_PAGE:
:END:")))
