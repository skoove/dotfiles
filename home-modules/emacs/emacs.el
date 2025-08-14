;; i want use-package for config but i do not want it to donwload anything:
(setq use-package-always-ensure nil)

(add-to-list 'load-path (expand-file-name "~/.emacs.d/lisp/"))

(use-package general)

;; vertico
(use-package vertico
  :init
  (vertico-mode))

;; emacs dashboard
(use-package dashboard
  :config
  (setq dashboard-startup-banner "~/.emacs.d/trans-flag.png")
  (setq dashboard-image-banner-max-width 200)
  (dashboard-setup-startup-hook))

; make dashboard show on client start even when runnign as daemon
(setq initial-buffer-choice (lambda () (get-buffer-create "*dashboard*")))
(add-hook 'server-after-make-frame-hook (lambda () (dashboard-refresh-buffer)))

;;; fuzzy completion
(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles basic partial-completion)))))

;;; direnv
(use-package direnv
 :config
 (direnv-mode))

;; consult
(use-package consult
  :bind
  (("C-x b"   . consult-buffer)
   ("C-x f" . consult-find)
   ("C-s"     . consult-line)
   ("M-g g"   . consult-goto-line)))

;;; treesit auto
(use-package treesit-auto
  :config
  (treesit-auto-add-to-auto-mode-alist 'all) 
  (global-treesit-auto-mode))

;;; which key setup
(which-key-mode)
(which-key-setup-side-window-bottom)
(setq which-key-idle-delay 0)

;;; theme
(load-theme 'gruvbox-dark-medium t)

(define-derived-mode my-git-commit-mode text-mode "mygitcommit"
  "majour mode for git commit messages"
  (setq-local fill-column 72)
  (auto-fill-mode 1)
  (setq-local comment-start "#")

  ;; Highlight first line if longer than 50 chars
  (defun my-git-header-warning-p (limit)
    "highlight header longer than 50 chars"
    (and (<= (line-number-at-pos) 1)
         (re-search-forward (format "^.\\{%d\\}\\(.*\\)$" (1+ 50)) limit t)))

  (font-lock-add-keywords
   nil `((my-git-header-warning-p 0 font-lock-warning-face prepend)))
  (let ((map my-git-commit-mode-map))
    ;; Save buffer and close (like git commit)
    (define-key map (kbd "C-c C-c")
		(lambda ()
		  (interactive)
		  (save-buffer)
		  (kill-buffer)))))

(add-to-list 'auto-mode-alist
	     '("/\\.git/COMMIT_EDITMSG\\'" . my-git-commit-mode))

;; get rid of extra autosave files, save to same file, also no backups
(setq make-backup-files nil)
(setq auto-save-default nil)

(defun my/auto-save ()
  "save buffers visiting files not things like dash"
  (dolist (buf (buffer-list))
    (with-current-buffer buf
      (when (and buffer-file-name
		 (buffer-modified-p))
	(save-buffer)))))

(run-with-idle-timer 3 t #'my/auto-save)

;; turn on line numbers
(global-display-line-numbers-mode)

;;; remove native stuff
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

;;; org
(require 'org)
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)
;; theme and edit like it is the native file
(setq org-src-fontify-natively t
    org-src-tab-acts-natively t
    org-confirm-babel-evaluate nil
    org-edit-src-content-indentation 0)

(defun my-org-faces ()
    (set-face-attribute 'org-level-1 nil :height 1.5)
    (set-face-attribute 'org-level-2 nil :height 1.4)
    (set-face-attribute 'org-level-3 nil :height 1.3)
    (set-face-attribute 'org-level-4 nil :height 1.2)
    (set-face-attribute 'org-level-5 nil :height 1.1))

(add-hook 'org-mode-hook #'my-org-faces)

;; wrap and center but not in src
(setq-default fill-column 80)
(add-hook 'org-mode-hook #'turn-on-auto-fill)

(defun my/org-mode-auto-fill-function ()
  "Only auto-fill outside of source blocks."
  (unless (org-in-src-block-p)
    (do-auto-fill)))

(add-hook 'org-mode-hook
          (lambda ()
            (setq-local auto-fill-function #'my/org-mode-auto-fill-function)))

;; typst preview
(require 'org-typst-preview)
(add-hook 'org-mode-hook #'org-typst-preview-render-buffer)

(defvar my/typst-render-toggle-state nil
  "tracks the state of typst rendering")

(defun my/toggle-typst-rendering ()
  "toggle typst rendering in org mode"
  (interactive)
  (if my/typst-render-toggle-state
      (progn
	(org-typst-preview-render-buffer)
	(setq my/typst-render-toggle-state nil))
    (progn
      (org-typst-preview-clear-buffer)
      (setq my/typst-render-toggle-state t))))

(general-define-key
 :keymaps 'org-mode-map
 "C-c t" 'my/toggle-typst-rendering)

;;; meow
(defun meow-setup ()
  (setq meow-cheatsheet-layout meow-cheatsheet-layout-qwerty)
  (meow-motion-define-key
   '("j" . meow-next)
   '("k" . meow-prev)
   '("<escape>" . ignore))
  (meow-leader-define-key
   ;; Use SPC (0-9) for digit arguments.
   '("1" . meow-digit-argument)
   '("2" . meow-digit-argument)
   '("3" . meow-digit-argument)
   '("4" . meow-digit-argument)
   '("5" . meow-digit-argument)
   '("6" . meow-digit-argument)
   '("7" . meow-digit-argument)
   '("8" . meow-digit-argument)
   '("9" . meow-digit-argument)
   '("0" . meow-digit-argument)
   '("/" . meow-keypad-describe-key)
   '("?" . meow-cheatsheet))
  (meow-normal-define-key
   '("0" . meow-expand-0)
   '("9" . meow-expand-9)
   '("8" . meow-expand-8)
   '("7" . meow-expand-7)
   '("6" . meow-expand-6)
   '("5" . meow-expand-5)
   '("4" . meow-expand-4)
   '("3" . meow-expand-3)
   '("2" . meow-expand-2)
   '("1" . meow-expand-1)
   '("-" . negative-argument)
   '(";" . meow-reverse)
   '("," . meow-inner-of-thing)
   '("." . meow-bounds-of-thing)
   '("[" . meow-beginning-of-thing)
   '("]" . meow-end-of-thing)
   '("a" . meow-append)
   '("A" . meow-open-below)
   '("b" . meow-back-word)
   '("B" . meow-back-symbol)
   '("c" . meow-change)
   '("d" . meow-delete)
   '("D" . meow-backward-delete)
   '("e" . meow-next-word)
   '("E" . meow-next-symbol)
   '("f" . meow-find)
   '("g" . meow-cancel-selection)
   '("G" . meow-grab)
   '("h" . meow-left)
   '("H" . meow-left-expand)
   '("i" . meow-insert)
   '("I" . meow-open-above)
   '("j" . meow-next)
   '("J" . meow-next-expand)
   '("k" . meow-prev)
   '("K" . meow-prev-expand)
   '("l" . meow-right)
   '("L" . meow-right-expand)
   '("m" . meow-join)
   '("n" . meow-search)
   '("o" . meow-block)
   '("O" . meow-to-block)
   '("p" . meow-yank)
   '("q" . meow-quit)
   '("Q" . meow-goto-line)
   '("r" . meow-replace)
   '("R" . meow-swap-grab)
   '("s" . meow-kill)
   '("t" . meow-till)
   '("u" . meow-undo)
   '("U" . undo-redo)
   '("v" . meow-visit)
   '("w" . meow-mark-word)
   '("W" . meow-mark-symbol)
   '("x" . meow-line)
   '("X" . meow-goto-line)
   '("y" . meow-save)
   '("Y" . meow-sync-grab)
   '("z" . meow-pop-selection)
   '("'" . repeat)
   '("<escape>" . ignore)))

(require 'meow)
(meow-setup)
(meow-global-mode 1)
(meow-tree-sitter-register-defaults)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(consult dashboard direnv general gruvbox-theme marginalia meow-tree-sitter
	     nix-mode orderless treesit-auto use-package vertico)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
