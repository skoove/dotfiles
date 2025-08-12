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

(which-key-mode)
