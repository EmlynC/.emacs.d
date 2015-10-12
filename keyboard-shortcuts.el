;; Linux, the menu/apps key syntax is <menu>
;; Windows, the menu/apps key syntax is <apps>
(define-key key-translation-map (kbd "<apps>") (kbd "<menu>")) ; make the syntax equal

; Toggle region comments
(global-set-key (kbd "M-/") 'comment-or-uncomment-region);

; Default to regexp searc
(global-set-key "\C-s" 'isearch-forward-regexp)

; setting Super ＆ Hyper keys for Apple keyboard, for emacs running in OS X
;; (setq mac-command-modifier 'meta) ; sets the Command key to Meta
;; (setq mac-option-modifier 'super) ; sets the Option key to Super
;; (setq mac-control-modifier 'control) ; sets the Control key to Control
;; (setq ns-function-modifier 'hyper)  ; set Mac's Fn key to Hyper

;; easy keys to split window. Key based on ErgoEmacs keybinding
(global-set-key (kbd "M-1") 'split-window-vertically) ; split pane top/bottom
(global-set-key (kbd "M-2") 'split-window-horizontally) ; split pane top/bottom
(global-set-key (kbd "M-3") 'delete-other-windows) ; expand current pane
(global-set-key (kbd "M-4") 'delete-window) ; close current pane
(global-set-key (kbd "M-s") 'other-window) ; cursor to other pane

; duplicate a line
(defun duplicate-line()
  (interactive)
  (move-beginning-of-line 1)
  (kill-line)
  (yank)
  (open-line 1)
  (next-line 1)
  (yank)
)
(global-set-key (kbd "M-d") 'duplicate-line)

; open buffer list in active window rather than other window
(global-set-key "\C-x\C-b" 'buffer-menu)

; set occur to C-o
(global-set-key (kbd "C-c o") 'occur)
