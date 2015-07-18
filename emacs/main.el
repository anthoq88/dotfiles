;; NOTE: use M-x `eval-buffer` to reload config

;;==== packages =====
(require 'package)
(push '("marmalade" . "http://marmalade-repo.org/packages/")
    package-archives )
(push '("melpa" . "http://melpa.milkbox.net/packages/")
    package-archives)

(package-initialize)

(require 'cl)

(defvar antho/packages
  '(ac-cider ac-helm ac-nrepl cider clojure-mode evil evil-easymotion
    evil-escape evil-leader evil-tabs helm helm-ag helm-projectile key-chord
    org colorsarenice-theme emmet-mode helm-emmet exec-path-from-shell
    flycheck magit perspective persp-projectile yaml-mode evil-surround
    json-mode json-reformat haskell-mode less-css-mode evil-easymotion powerline
    multiple-cursors relative-line-numbers)
  "List of packages to ensure are installed at launch")

(defun antho/packages-installed-p ()
  (loop for p in antho/packages
	when (not (package-installed-p p)) do (return nil)
	finally (return t)))

(unless (antho/packages-installed-p)
  (message "%s" "Emacs is now refreshing its package database...")
  (package-refresh-contents)
  (message "%s" " done.")

  (dolist (p antho/packages)
    (when (not (package-installed-p p))
      (package-install p))))

(provide 'antho/packages)

(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

(setq-default indent-tabs-mode nil)
(show-paren-mode t)
		   
(setenv "PATH" (concat (getenv "PATH") ":/Users/anthonyquizon/.npm-packages/bin"))
(setq exec-path (append exec-path '("/Users/anthonyquizon/.npm-packages/bin")))

;;;=== Registers ===
;;http://www.gnu.org/software/emacs/manual/html_node/emacs/Registers.html
(set-register ?e (cons 'file "~/.emacs"))

;=============
(evil-mode 1)

(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

(setq column-number-mode t)
(setq inhibit-startup-message t)

(global-linum-mode t)

(set-face-attribute 'default (selected-frame) :font "Monaco-14")
(add-to-list 'initial-frame-alist '(font . "Monaco-14"))
(add-to-list 'default-frame-alist '(font . "Monaco-14"))


(setq ring-bell-function 'ignore)
(setq bell-volume 0)

(add-to-list 'exec-path "/usr/local/bin")

(setq scroll-margin 5
      scroll-conservatively 9999
      scroll-step 1)

(eval-after-load 'esh-opt
  '(progn
    (defun antho/eshell-mode-hook()
      (setq eshell-path-env (concat "/usr/local/bin:" eshell-path-env))
      
      (define-key eshell-mode-map (kbd "C-j") 'eshell-next-input)
      (define-key eshell-mode-map (kbd "C-k") 'eshell-previous-input)
      (setenv "PATH" (concat "/usr/local/bin:" (getenv "PATH"))))

    (add-hook 'eshell-mode-hook 'antho/eshell-mode-hook)))

(add-hook 'dired-mode-hook 'dired-hide-details-mode)
(add-hook 'dired-mode-hook 'auto-revert-mode)

(define-key input-decode-map "\e[1;5A" [C-up])

(setq make-backup-files nil)
(setq auto-save-default nil)
(setq create-lockfiles nil)
;; (setq backup-directory-alist `(("." . "~/.emacs-backup")))

(setq mac-command-modifier 'super)
(global-set-key (kbd "s-<right>") 'move-end-of-line)
(global-set-key (kbd "s-<left>") 'move-beginning-of-line)

;;override list buffer with dired mode
(global-set-key (kbd "C-x C-d") 'dired) 

(define-key input-decode-map "\e[1;5A" [C-up])
(define-key input-decode-map "\e[1;5B" [C-down])


(defun antho/dired-mode-keybindings ()
  (define-key dired-mode-map (kbd "C-j") 'evil-next-line)
  (define-key dired-mode-map (kbd "C-k") 'evil-previous-line)
  (define-key dired-mode-map (kbd "C-h") 'evil-backward-char)
  (define-key dired-mode-map (kbd "C-l") 'evil-forward-char)
  (define-key dired-mode-map (kbd "g") nil)
  (define-key dired-mode-map (kbd "G") nil)
  (define-key dired-mode-map (kbd "r") 'revert-buffer))
   
(add-hook 'dired-mode-hook 'antho/dired-mode-keybindings)

;==== Theme =====
(load-theme 'colorsarenice-dark t)

;===== Evil Mode ======

(key-chord-mode 1)
(key-chord-define evil-insert-state-map  "jk" 'evil-normal-state)

(define-key evil-normal-state-map (kbd "j") 'evil-next-visual-line)
(define-key evil-normal-state-map (kbd "k") 'evil-previous-visual-line)
(define-key evil-motion-state-map (kbd "K") nil)
(define-key evil-normal-state-map (kbd "K") nil)

(define-key evil-insert-state-map (kbd "C-j") nil)
(define-key evil-motion-state-map (kbd "C-j") nil)
(define-key evil-normal-state-map (kbd "C-j") nil)
(define-key evil-insert-state-map (kbd "C-k") nil)
(define-key evil-motion-state-map (kbd "C-k") nil)
(define-key evil-normal-state-map (kbd "C-k") nil)

(define-key evil-visual-state-map (kbd "u") nil)

(setq evil-emacs-state-cursor '(box))
(setq evil-normal-state-cursor '(box))
(setq evil-visual-state-cursor '(box))
(setq evil-insert-state-cursor '(bar))
(setq evil-replace-state-cursor '(hollow))

;; esc quits
(defun minibuffer-keyboard-quit ()
  "Abort recursive edit.
In Delete Selection mode, if the mark is active, just deactivate it;
then it takes a second \\[keyboard-quit] to abort the minibuffer."
  (interactive)
  (if (and delete-selection-mode transient-mark-mode mark-active)
      (setq deactivate-mark  t)
    (when (get-buffer "*Completions*") (delete-windows-on "*Completions*"))
    (abort-recursive-edit)))
(define-key evil-normal-state-map [escape] 'keyboard-quit)
(define-key evil-visual-state-map [escape] 'keyboard-quit)
(define-key minibuffer-local-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-ns-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-completion-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-must-match-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-isearch-map [escape] 'minibuffer-keyboard-quit)
(global-set-key [escape] 'evil-exit-emacs-state)


;===== Helm ======
(require 'helm-config)
(helm-mode 1)

(global-set-key (kbd "C-x f") 'helm-recentf)

(define-key helm-map (kbd "<tab>") nil)
(define-key helm-map (kbd "C-l") nil)
(define-key helm-map (kbd "C-h") nil) 
(define-key helm-map (kbd "C-z") nil)
(define-key helm-map (kbd "C-j") nil)
(define-key helm-map (kbd "C-k") nil)

(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action)
(define-key helm-map (kbd "C-l") 'helm-execute-persistent-action)
(define-key helm-map (kbd "C-h") 'helm-find-files-up-one-level) 
(define-key helm-map (kbd "C-z") 'helm-select-action)
(define-key helm-map (kbd "C-j") 'helm-next-line)
(define-key helm-map (kbd "C-k") 'helm-previous-line)
    
(define-key helm-find-files-map (kbd "<tab>") 'helm-execute-persistent-action)
(define-key helm-find-files-map (kbd "C-l") 'helm-execute-persistent-action)
(define-key helm-find-files-map (kbd "C-h") 'helm-find-files-up-one-level) 
(define-key helm-find-files-map (kbd "C-z") 'helm-select-action)
(define-key helm-find-files-map (kbd "C-j") 'helm-next-line)
(define-key helm-find-files-map (kbd "C-k") 'helm-previous-line)

(define-key helm-read-file-map (kbd "<tab>") 'helm-execute-persistent-action)
(define-key helm-read-file-map (kbd "C-l") 'helm-execute-persistent-action)
(define-key helm-read-file-map (kbd "C-h") 'helm-find-files-up-one-level) 
(define-key helm-read-file-map (kbd "C-z") 'helm-select-action)
(define-key helm-read-file-map (kbd "C-j") 'helm-next-line)
(define-key helm-read-file-map (kbd "C-k") 'helm-previous-line)

;; ==== Evil Leader ====
(global-evil-leader-mode)

;;===== Cider ====

(defun antho/cider-repl-mode-keybindings()
    (define-key cider-repl-mode-map (kbd "C-j") 'cider-repl-next-input)
    (define-key cider-repl-mode-map (kbd "C-k") 'cider-repl-previous-input))
    
(add-hook 'cider-mode-hook 'ac-flyspell-workaround)
(add-hook 'cider-mode-hook 'ac-cider-setup)
(add-hook 'cider-repl-mode-hook 'ac-cider-setup)
(add-hook 'cider-repl-mode-hook 'antho/cider-repl-mode-keybindings)
(setq cider-show-error-buffer 'only-in-repl)

(eval-after-load "auto-complete"
  '(progn
     (add-to-list 'ac-modes 'cider-mode)
     (add-to-list 'ac-modes 'cider-repl-mode)))

(defun antho/search-keybinding()
  (interactive)
  ;;TODO check if visual mode
  (evil-ex (concat "%s/" (thing-at-point 'word) "/")))

(defun antho/search-keybinding-empty()
  (interactive)
  ;;TODO check if visual mode
  (evil-ex (concat "%s/")))


(evil-leader/set-key
  "l" 'evil-lookup
  "e" 'eshell
  "b" 'eval-buffer
  "s" 'antho/search-keybinding
  "S" 'antho/search-keybinding-empty
  "p" 'mode-line-other-buffer)

;;=== Projectile ====
(projectile-global-mode)
(setq projectile-completion-system 'helm)
(helm-projectile-on)

;;==== Emmet ====
(add-hook 'sgml-mode-hook 'emmet-mode) ;; Auto-start on any markup modes
(add-hook 'css-mode-hook  'emmet-mode) ;; enable Emmet's css abbreviation.

;;==== Flymake ===
(add-hook 'after-init-hook #'global-flycheck-mode)

;;==== Projectile ===
(projectile-global-mode)
(helm-projectile-on)

;;=== Perspective ====
(persp-mode)

(define-key projectile-mode-map (kbd "C-x x h") 'projectile-persp-switch-project)


;;==== Magit =====
(global-set-key (kbd "C-c g") 'magit-status)

;; copied from https://github.com/tarleb/evil-rebellion
;; Start to insert mode when editing commit messages
(evil-set-initial-state 'magit-log-edit-mode 'insert)
(evil-set-initial-state 'git-commit-mode 'insert)


(evil-add-hjkl-bindings magit-branch-manager-mode-map 'emacs
  "K" 'magit-discard-item
  "L" 'magit-key-mode-popup-logging)
(evil-add-hjkl-bindings magit-status-mode-map 'emacs
  "K" 'magit-discard-item
  "l" 'magit-key-mode-popup-logging
  "h" 'magit-toggle-diff-refine-hunk)
(evil-add-hjkl-bindings magit-status-mode-map 'emacs)
(evil-add-hjkl-bindings magit-log-mode-map 'emacs)
(evil-add-hjkl-bindings magit-commit-mode-map 'emacs)
(evil-add-hjkl-bindings occur-mode 'emacs)

(eval-after-load "magit"
  '(progn
     (define-key evil-normal-state-map (kbd "C-w h") 'evil-window-left)
     (define-key evil-normal-state-map (kbd "C-w j") 'evil-window-down)
     (define-key evil-normal-state-map (kbd "C-w k") 'evil-window-up)
     (define-key evil-normal-state-map (kbd "C-w l") 'evil-window-right)))

;; This should already exist in your custom.el file.
(custom-set-variables
 ;; This should also already exist, you'll want to append onto the
 ;; long list of modes.
 '(evil-emacs-state-modes (quote (magit-commit-mode magit-log-mode magit-stash-mode magit-status-mode))))


;;==== Evil Surround ====
(global-evil-surround-mode 1)

(powerline-default-theme)

;; ===== Evil Easy motion ======
(evilem-default-keybindings "SPC")


;;==== less mode =====

;; (defun antho/less-css-mode-hook() 
;;   (electric-indent-mode nil))

;; (add-hook 'less-css-mode 'antho/less-css-mode-hook)


(defun open-finder-1 (dir file)
  (let ((script
		 (if file
			 (concat
			  "tell application \"Finder\"\n"
			  "    set frontmost to true\n"
			  "    make new Finder window to (POSIX file \"" dir "\")\n" 
			  "    select file \"" file "\"\n"
			  "end tell\n")
		   (concat
			"tell application \"Finder\"\n"
			"    set frontmost to true\n"
			"    make new Finder window to {path to desktop folder}\n"
			"end tell\n"))))
    (start-process "osascript-getinfo" nil "osascript" "-e" script)))
 
 
(defun open-finder ()
  (interactive)
  (let ((path (buffer-file-name))
		dir file)
	(when path
	  (setq dir (file-name-directory path))
	  (setq file (file-name-nondirectory path)))
	(open-finder-1 dir file)))
  
(defalias 'e 'open-finder)


;; ==== multiple cursors ======
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)

(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)




;; ==== purescript ====
(setq auto-mode-alist 
      (append '((".*\\.purs\\'" . haskell-mode))
              auto-mode-alist))

;; ===== haskell-mode ====
;; (add-hook 'haskell-mode-hook 'turn-on-haskell-simple-indent)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indent)


;; === relative line numbers
(add-hook 'prog-mode-hook 'relative-line-numbers-mode t)
(add-hook 'prog-mode-hook 'line-number-mode t)
(add-hook 'prog-mode-hook 'column-number-mode t)

;;; .emacs ends here
