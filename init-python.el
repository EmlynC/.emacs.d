;------------------------;
;;; Python Programming ;;;
;------------------------;

(require 'python)
(require 'pyenv-mode)

;; general
(add-hook 'python-mode-hook
      (lambda ()
        (setq indent-tabs-mode t)
        (setq tab-width 4)
        (setq python-indent 4)))

;; electric pair
;; (add-hook 'python-mode-hook
;;   (lambda () (define-key python-mode-map "\"" 'electric-pair)
;;     (define-key python-mode-map "\'" 'electric-pair)
;;     (define-key python-mode-map "(" 'electric-pair)
;;     (define-key python-mode-map "[" 'electric-pair)
;;     (define-key python-mode-map "{" 'electric-pair)))

;; python 3 by default!
;(pyvenv-activate (expand-file-name "~/anaconda/envs/py3k"))

;; -----------------------
;; python.el configuration
;; -----------------------

; from python.el

(setq
 python-shell-interpreter "ipython"
 ;; python-shell-interpreter-args (if (system-is-mac)
 ;;    			   "--gui=osx --matplotlib=osx --colors=Linux"
 ;;                                   (if (system-is-linux)
 ;;    			       "--gui=wx --matplotlib=wx --colors=Linux"))
 python-shell-prompt-regexp "In \\[[0-9]+\\]: "
 python-shell-prompt-output-regexp "Out\\[[0-9]+\\]: "
 python-shell-completion-setup-code
   "from IPython.core.completerlib import module_completion"
 python-shell-completion-module-string-code
   "';'.join(module_completion('''%s'''))\n"
 python-shell-completion-string-code
   "';'.join(get_ipython().Completer.all_completions('''%s'''))\n")

;; -----------------------------
;; emacs IPython notebook config
;; -----------------------------

; use autocompletion, but don't start to autocomplete after a dot
(setq ein:complete-on-dot -1)
(setq ein:use-auto-complete 1)

; set python console args
(setq ein:console-args
      (if (system-is-mac)
	  '("--gui=osx" "--matplotlib=osx" "--colors=Linux")
	(if (system-is-linux)
	    '("--gui=wx" "--matplotlib=wx" "--colors=Linux"))))

; timeout settings
(setq ein:query-timeout 1000)

; IPython notebook
(require 'ein)

; shortcut function to load notebooklist
(defun load-ein () 
  (ein:notebooklist-load)
  (interactive)
  (ein:notebooklist-open))

;; virtualenv
(require 'virtualenvwrapper)
(venv-initialize-interactive-shells) ;; if you want interactive shell support
(venv-initialize-eshell) ;; if you want eshell support
(setq venv-location "/Users/emlyn/.virtualenvs/")

;; Jedi for autocompletion
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)                 ; optional


;; ------------------
;; misc python config
;; ------------------

; pydoc info
(require 'pydoc-info)
