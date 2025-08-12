;; i want use-package for config but i do not want it to donwload anything:
(setq use-package-always-ensure nil)

(use-package vertico
  :init
  (vertico-mode))

;; fuzzy completion
(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles basic partial-completion)))))

(use-package direnv
 :config
 (direnv-mode))

(use-package treesit-auto
  :config
  (treesit-auto-add-to-auto-mode-alist 'all) ;; if a treesitter grammar is found for the language detected in the buffer, use the corresponding language-ts-mode
  (global-treesit-auto-mode))

(which-key-mode)

