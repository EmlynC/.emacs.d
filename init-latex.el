;; BASIC

(require 'tex)

; fix to use ispell
(setq ispell-list-command "--list")

;(define-key LaTeX-mode-map [M-S-mouse-1] 'TeX-view)

(setq-default TeX-master nil)       ; query for the master file
(add-hook 'LaTeX-mode-hook 'visual-line-mode)  ; show which line I'm on
(add-hook 'LaTeX-mode-hook 'flyspell-mode)     ; spell check by default
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode) 
(setq reftex-plug-into-AUCTeX t)               ; integrate reftex with latex
(setq TeX-PDF-mode t)  ; default to PDF mode
(setq TeX-auto-save t) ; save the intermediates 
(setq TeX-parse-self t)

;; Use Skim as viewer, enable source <-> PDF sync
;; make latexmk available via C-c C-c
;; Note: SyncTeX is setup via ~/.latexmkrc (see below)
(add-hook 'LaTeX-mode-hook (lambda ()
  (push
    '("latexmk" "latexmk -pdf %s" TeX-run-TeX nil t
      :help "Run latexmk on file")
    TeX-command-list)))
(add-hook 'TeX-mode-hook '(lambda () (setq TeX-command-default "latexmk")))

;; use Skim as default pdf viewer
;; Skim's displayline is used for forward search (from .tex to .pdf)
;; option -b highlights the current line; option -g opens Skim in the background  
(setq TeX-view-program-selection '((output-pdf "PDF Viewer")))
(setq TeX-view-program-list
     '(("PDF Viewer" "/Applications/Skim.app/Contents/SharedSupport/displayline -a -b -g %n %o %b")))

(server-start); start emacs in server mode so that skim can talk to it

;; REFTEX

; Turn reftex on 
(setq reftex-enable-partial-scans t)
(setq reftex-save-parse-info t)
(setq reftex-use-multiple-selection-buffers t)

(autoload 'reftex-mode "reftex" "RefTeX Minor Mode" t)
(autoload 'turn-on-reftex "reftex" "RefTeX Minor Mode" nil)
(autoload 'reftex-label "reftex-label" "Make label" nil)
(autoload 'reftex-reference "reftex-reference" "Make label" nil)
(autoload 'reftex-citation "reftex-cite" "Make citation" nil)
(autoload 'reftex-index-phrase-mode "reftex-index" "Phrase Mode" t)
(add-hook 'latex-mode-hook 'turn-on-reftex) ; with Emacs latex mode
(add-hook 'reftex-load-hook 'imenu-add-menubar-index)
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)

(setq LaTeX-eqnarray-label "eq" LaTeX-equation-label "eq"
 LaTeX-figure-label "fig" LaTeX-table-label "tab"
 LaTeX-myChapter-label "chap" TeX-auto-save t
 TeX-newline-function 'reindent-then-newline-and-indent
 TeX-parse-self t LaTeX-section-hook '(LaTeX-section-heading
 LaTeX-section-title LaTeX-section-toc LaTeX-section-section
 LaTeX-section-label))

(eval-after-load
   "latex"
 '(TeX-add-style-hook
   "cleveref"
   (lambda ()
     (if (boundp 'reftex-ref-style-alist)
         (add-to-list
          'reftex-ref-style-alist
          '("Cleveref" "cleveref"
            (("\\cref" ?c) ("\\Cref" ?C) ("\\cpageref" ?d) ("\\Cpageref" ?D)))))
     (add-to-list 'reftex-ref-style-default-list "Cleveref")
     (TeX-add-symbols
      '("cref" TeX-arg-ref)
      '("Cref" TeX-arg-ref)
      '("cpageref" TeX-arg-ref)
      '("Cpageref" TeX-arg-ref)))))

;; So that RefTeX recognizes bibliographies in \addbibresource
(setq reftex-bibliography-commands (quote ("addbibresource")))

;; TEXCOUNT
(require 'tex)
(add-to-list 'TeX-command-list
      (list "texcount" "texcount -inc %s.tex" 'TeX-run-command nil t))

; Use the texlive/2012 directory path
(getenv "PATH")
 (setenv "PATH"
(concat
 "/opt/texbin" ":"

(getenv "PATH"))) 
