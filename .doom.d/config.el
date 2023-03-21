(setq display-line-numbers-type 'relative)

(setq doom-font (font-spec :family "JetBrainsMono Nerd Font" :size 15))
(setq-default cursor-type 'box)

(setq org-directory "~/Stuff/org/")

(require 'org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

(global-set-key (kbd "<f12>") 'org-babel-tangle)

(setq doom-theme 'doom-gruvbox)

;;(set-frame-parameter (selected-frame) 'alpha'( 95 . 50 ))
;;(add-to-list 'default-frame-alist '(alpha. (95 . 50)))
