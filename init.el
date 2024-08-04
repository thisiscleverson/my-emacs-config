;; Remover boas-vindas do Emacs
(setq inhibit-startup-message t)

;; Remover Menus
(tool-bar-mode -1)
;(menu-bar-mode -1)

;; Numeros nas linhas
(global-display-line-numbers-mode t)

;; MELPA
(require 'package)
(add-to-list 'package-archives '("MELPA" . "http://melpa.org/packages/"))

(add-to-list 'load-path "~/.emacs.d/neotree")
(require 'neotree)
(global-set-key [(control ?b)] 'neotree-toggle)
(setq neo-theme (if (display-graphic-p) 'icons 'arrow))

(unless (package-installed-p 'gruvbox-theme)
  (package-refresh-contents)
  (package-install 'gruvbox-theme))

(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(use-package try
  :ensure t)

(use-package which-key
  :ensure t
  :config (which-key-mode))

(use-package auto-complete
  :ensure t
  :init
  (progn
    (ac-config-default)
    (global-auto-complete-mode t)))

;; all-the-icons
(use-package all-the-icons
  :if (display-graphic-p))

(use-package ergoemacs-mode
  :ensure t
  :config
  (progn
    (setq ergoemacs-theme nil)
    (setq ergoemacs-keyboard-layout "us")
    (ergoemacs-mode 1)))

;; Colocar o tema no neotree
(setq neo-theme (if (display-graphic-p) 'icons 'arrow))

;; definir tema
(require 'gruvbox-theme)
(load-theme 'gruvbox t)


;; Python autocomplete-jedi
(add-hook 'python-mode-hook 'jedi:ac-setup)
(setq jedi:complete-on-dot t)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("046a2b81d13afddae309930ef85d458c4f5d278a69448e5a5261a5c78598e012" "d445c7b530713eac282ecdeea07a8fa59692c83045bf84dd112dd738c7bcad1d" default))
 '(package-selected-packages '(which-key try)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
