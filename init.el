; Emlyn's emacs' config 8th October 2015

;; PACKAGE MANAGEMENT
(require 'package)
(package-initialize)
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("melpa" . "http://melpa.org/packages/")))

(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(unless (require 'el-get nil t)
  (url-retrieve
   "https://raw.github.com/dimitri/el-get/master/el-get-install.el"
   (lambda (s)
     (end-of-buffer)
     (eval-print-last-sexp))))

;; LOAD PATHS
(setq plugin-path "~/.emacs.d/elpa/")
(add-to-list 'load-path "~/.emacs.d/elisp/")
 
;; GENERAL

;; set home as the default directory and find-file to start from home
;;(setq-default default-directory "~/")

;; define various custom functions
;(require 'custom-functions)

; always show matching parenthesis
(show-paren-mode 1)

; enable ido mode for searching for files
(setq ido-enable-flex-matching t)
(setq ido-everything t)
(ido-mode t)

; enable autocomplete; auto completes symbols and words 
(require 'auto-complete)
(require 'auto-complete-config)
(ac-config-default)
(global-auto-complete-mode t)

; enable fill column indicator for PEP-8 goodness!
(require 'fill-column-indicator)
(define-globalized-minor-mode
 global-fci-mode fci-mode (lambda () (fci-mode 1)))
(set 'fci-rule-width 80)
(global-fci-mode t)

; enable yas mode for snippets
(require 'yasnippet)

(setq yas-snippet-dirs
      '("~/.emacs.d/snippets"                 ;; personal snippets
        ))

(yas-global-mode 1)

; Use aspell rather than ispell
(setq ispell-program-name "/opt/local/bin/aspell")

(defun dired-do-ispell (&optional arg)
  (interactive "P")
  (dolist (file (dired-get-marked-files
                 nil arg
                 #'(lambda (f)
                     (not (file-directory-p f)))))
    (save-window-excursion
      (with-current-buffer (find-file file)
        (ispell-buffer)))
    (message nil)))

; keyboard shortcuts
(load "~/.emacs.d/keyboard-shortcuts.el")

;; store all backup and autosave files in the tmp dir
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))


; Mac OSX
(require 'exec-path-from-shell)
(when (memq window-system '(mac ns))  ; when on a Mac get the shell path from the bash_profile
  (exec-path-from-shell-initialize)
  (setq-default default-directory "~/"))

;; THEME
; change theme to solarized theme
(add-to-list 'load-path "~/.emacs.d/themes/emacs-color-theme-solarized")
(if
    (equal 0 (string-match "^24" emacs-version))
    ;; it's emacs24, so use built-in theme
    (require 'solarized-dark-theme)
  ;; it's NOT emacs24, so use color-theme
  (progn
    (require 'color-theme)
    (color-theme-initialize)
    (require 'color-theme-solarized)
    (color-theme-solarized-dark)))


;; FILE MODE INITS

; Latex, *.tex
;(autoload 'latex-mode "init-latex" "" t)
;(eval-after-load 'LaTeX-mode 'load("init-latex.el"))
(load-file "~/.emacs.d/init-latex.el")

; Python, *.py
(load-file "~/.emacs.d/init-python.el")
;(autoload 'python-mode "(init-python.el"))

; Markdown *.md
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(markdown-command "/Users/emlyn/Library/Haskell/bin/pandoc")
 '(python-shell-interpreter "ipython"))


;; UTILITIES

; repeat.el
(load-file "~/.emacs.d/init-repeat.el")

; switch to minibuffer
(defun switch-to-minibuffer ()
  "Switch to minibuffer window."
  (interactive)
  (if (active-minibuffer-window)
      (select-window (active-minibuffer-window))
    (error "Minibuffer is not active")))

(global-set-key "\C-co" 'switch-to-minibuffer) ;; Bind to `C-c o'
(put 'downcase-region 'disabled nil)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
