;; i want use-package for config but i do not want it to donwload anything:
(setq use-package-always-ensure nil)

;; vertico
(use-package vertico
  :init
  (vertico-mode))

;;; fuzzy completion
(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles basic partial-completion)))))

;;; direnv
(use-package direnv
 :config
 (direnv-mode))

;;; treesit auto
(use-package treesit-auto
  :config
  (treesit-auto-add-to-auto-mode-alist 'all) 
  (global-treesit-auto-mode))

;;; which key setup
(which-key-mode)
(which-key-setup-side-window-right-bottom)
(setq which-key-idle-delay 0)

;;; theme
(load-theme 'gruvbox-dark-medium t)
