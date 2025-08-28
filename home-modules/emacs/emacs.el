;; i wnt use-package for config but i do not want it to donwload anything:
(setq use-package-always-ensure nil)

(load-theme 'gruvbox-dark-medium t)
(add-to-list 'load-path (expand-file-name "~/.emacs.d/lisp/"))
(setq ispell-program-name "aspell")
(setq ispell-dictionary "en_AU")
(elcord-mode)
(setq-default truncate-lines t)
(windmove-default-keybindings)
(page-break-lines-mode)
(org-node-backlink-mode)

(set-face-attribute 'default nil :family "JetBrains Nerd Font Mono" :height 100)

;; vertico
(use-package vertico
  :init
  (vertico-mode))

;; projectiole
(projectile-mode +1)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)

;; emacs dashboard
(require 'all-the-icons)
(require 'page-break-lines)
(require 'projectile)

(use-package dashboard
  :config
  (setq dashboard-startup-banner 'logo)
  (setq dashboard-items '((recents   . 10)
                          (projects  . 10)
                          (agenda    . 10)))
  (setq dashboard-display-icons-p t)    
  (setq dashboard-icon-type 'all-the-icons)
  (setq dashboard-set-heading-icons t)
  (setq dashboard-set-file-icons t)
  (setq dashboard-projects-backend 'projectile)
  (dashboard-modify-heading-icons '((recents   . "clock")
				    (projects  . "file-directory")
				    (agenda    . "calendar")))
  (setq dashboard-page-separator "\n\f\n")
  (dashboard-setup-startup-hook))

;; make dashboard show on client start even when runnign as daemon
(setq initial-buffer-choice (lambda () (get-buffer-create "*dashboard*")))
(add-hook 'server-after-make-frame-hook (lambda () (dashboard-refresh-buffer)))

;; fuzzy completion
(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles basic partial-completion)))))

;; direnv
(use-package direnv
 :config
 (direnv-mode))

;; consult
(use-package consult
  :bind
  (("C-x b"   . consult-buffer)
   ("C-s"     . consult-line)
   ("M-g g"   . consult-goto-line)))

;; treesit auto
(use-package treesit-auto
  :config
  (treesit-auto-add-to-auto-mode-alist 'all) 
  (global-treesit-auto-mode))

;; which key setup
(which-key-mode)
(which-key-setup-side-window-bottom)
(setq which-key-idle-delay 0)

(define-derived-mode zie-git-commit-mode text-mode "ziegitcommit"
  "majour mode for git commit messages"
  (setq-local fill-column 72)
  (auto-fill-mode 1)
  (setq-local comment-start "#")

  (defun zie/git-header-warning (limit)
    "highlight header longer than 50 chars"
    (and (<= (line-number-at-pos) 1)
         (re-search-forward (format "^.\\{%d\\}\\(.*\\)$" (1+ 50)) limit t)))

  (font-lock-add-keywords
   nil `((zie/git-header-warning 0 font-lock-warning-face prepend)))
  (let ((map zie-git-commit-mode-map))
    (define-key map (kbd "C-c C-c")
		(lambda ()
		  (interactive)
		  (save-buffer)
		  (kill-buffer)))))

(add-to-list 'auto-mode-alist
	     '("/\\.git/COMMIT_EDITMSG\\'" . zie-git-commit-mode))

;; get rid of extra autosave files, save to same file, also no backups
(setq make-backup-files nil)
(setq auto-save-default nil)

(defun zie/auto-save ()
  "save buffers visiting files not things like dash"
  (dolist (buf (buffer-list))
    (with-current-buffer buf
      (when (and buffer-file-name
		 (buffer-modified-p))
	(save-buffer)))))

(run-with-idle-timer 3 t #'zie/auto-save)

;; turn on line numbers
(global-display-line-numbers-mode)

;; remove native stuff
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

;; org
(require 'org)

(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)

(setq org-agenda-files '("~/org/"))
(setq org-log-done t)
(setq org-image-actual-width nil) ; make images be set my #+ATTR_ORG: :width
;; theme and edit like it is the native file
(setq org-src-fontify-natively t
    org-src-tab-acts-natively t
    org-confirm-babel-evaluate nil
    org-edit-src-content-indentation 0)

(defun zie/org-setup ()
  ;; visual fill
  (setq-local fill-column 80)
  (visual-fill-column-mode 1)
  (visual-line-mode 1)
  ;; spell check
  (flyspell-mode 1)
  ;; indent mode
  (setq-local org-hide-leading-stars t)
  (org-indent-mode 1))

(add-hook 'org-mode-hook
	  (lambda ()
	    (zie/org-setup)))

(use-package org-mem
  :defer
  :config
  (setq org-mem-do-sync-with-org-id t)
  (setq org-mem-watch-dirs (list "~/org"))
  (org-mem-updater-mode))

(use-package org-node
  :init
  ;; Optional key bindings
  (keymap-global-set "M-o" org-node-global-prefix-map)
  (with-eval-after-load 'org
    (keymap-set org-mode-map "M-o" org-node-org-prefix-map))
  :config
  (org-node-cache-mode))

;; markdown mode
(use-package markdown-mode
  :mode ("README\\.md\\'" . gfm-mode)
  :init
  (setq markdown-command "multimarkdown")
  :hook (markdown-mode . (lambda ()
		     (setq-local fill-column 80)
		     (visual-line-mode 1)
		     (dolist (face '((markdown-header-face-1 . 1.5)
				     (markdown-header-face-2 . 1.3)
				     (markdown-header-face-3 . 1.2)
				     (markdown-header-face-4 . 1.1)))
		       (set-face-attribute (car face) nil :height (cdr face) :weight 'bold))))
  :bind (:map markdown-mode-map
              ("C-c C-e" . markdown-do)))

;; better column fill
(use-package visual-fill-column
  :hook (visual-line-mode . visual-fill-column-mode)
  :config
  (setq visual-fill-column-width 80
        visual-fill-column-center-text nil))

;; typst preview
(require 'org-typst-preview)
(add-hook 'org-mode-hook #'org-typst-preview-render-buffer)

(defvar zie/typst-render-toggle-state nil
  "tracks the state of typst rendering")

(defun zie/toggle-typst-rendering ()
  "toggle typst rendering in org mode"
  (interactive)
  (if zie/typst-render-toggle-state
      (progn
	(org-typst-preview-render-buffer)
	(setq zie/typst-render-toggle-state nil))
    (progn
      (org-typst-preview-clear-buffer)
      (setq zie/typst-render-toggle-state t))))

(define-key org-mode-map (kbd "C-c t") 'zie/toggle-typst-rendering)

(defun zie/insert-typst-math ()
  "insert typst math"
  (interactive)
  (insert "#[ $$ #]")
  (backward-char 4))

(define-key org-mode-map (kbd "C-c e") 'zie/insert-typst-math)

;; term launcher in dir
(defun zie/open-terminal ()
  "launch termianl in the currently open directory"
  (interactive)
  (call-process-shell-command
   (concat "footclient -D " default-directory) nil 0))

;; meow
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

;; general
(require 'general)
(general-define-key
 :keymaps 'global
 "C-c n" 'zie/open-terminal
 "C-c f" 'make-frame
 "C-c d" 'dashboard-open
 "C-x f" 'projectile-find-file)
