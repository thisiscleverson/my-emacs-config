;; Desativar a mensagem de boas-vindas
(setq inhibit-startup-message t)

;; Remover barras de ferramentas e menus
(tool-bar-mode -1)
;;(menu-bar-mode -1)  ;; Descomente esta linha se você quiser remover a barra de menus

;; Exibir números nas linhas
(global-display-line-numbers-mode t)

;; Desativar arquivos de backup (~) e auto-save (#)
(setq make-backup-files nil)
(setq auto-save-default nil)

;; resize easy
;(global-set-key (kbd "C-<right>") 'shrink-window-horizontally)
;(global-set-key (kbd "C-<left>") 'enlarge-window-horizontally)
;(global-set-key (kbd "C-<up>") 'enlarge-window)
;(global-set-key (kbd "C-<down>") 'shrink-window)

;; Configuração do repositório MELPA
(require 'package)
(add-to-list 'package-archives '("MELPA" . "https://melpa.org/packages/"))
(package-initialize)

;; Instalar e configurar o `use-package`
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)

;; Tema Gruvbox
(use-package gruvbox-theme
  :ensure t
  :config
  (load-theme 'gruvbox t))

;; Configuração de atalhos de teclado com `ergoemacs-mode`
(use-package ergoemacs-mode
  :ensure t
  :config
  (setq ergoemacs-theme nil)
  (setq ergoemacs-keyboard-layout "us")
  (ergoemacs-mode 1))

;; Instalar e configurar Jedi com `use-package`
(use-package jedi
  :ensure t
  :config
  (add-hook 'python-mode-hook 'jedi:setup)
  (setq jedi:complete-on-dot t))

;; Barra lateral Neotree com ícones
(use-package neotree
  :ensure t
  :config
  (global-set-key (kbd "C-S-b") 'neotree-toggle)
  (setq neo-theme (if (display-graphic-p) 'icons 'arrow)))

;; Linter para Python com Flycheck
(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))

;; Which-key para dicas de teclas
(use-package which-key
  :ensure t
  :config (which-key-mode))

;; Instalar ícones para o modo gráfico
(use-package all-the-icons
  :if (display-graphic-p))

;; Use-package para tentar pacotes
(use-package try
  :ensure t)

;; Configuração do auto-complete para Python
(use-package auto-complete
  :ensure t
  :config
  (ac-config-default)
  (setq ac-sources
        '(ac-source-words-in-same-mode-buffers
          ac-source-words-in-buffer
          ac-source-yasnippet))
  (add-hook 'python-mode-hook
            (lambda ()
              (auto-complete-mode 1)
              ;; Verifique se ac-source-rope é um fonte válida ou substitua por alternativas
              (set (make-local-variable 'ac-sources)
                   (append ac-sources '(ac-source-yasnippet)))
              (setq ac-find-function 'ac-python-find)
              (setq ac-candidate-function 'ac-python-candidate)
              (setq ac-auto-start nil))))

;; auto-complete
(use-package auto-complete
  :ensure t
  :init
  (progn
    (ac-config-default)
    (global-auto-complete-mode t)))



;; shell-pop
(use-package shell-pop
  :ensure t
  :custom
  (shell-pop-shell-type '("ansi-term" "*shell-pop-ansi-term*" (lambda () (ansi-term shell-pop-term-shell))))
  (shell-pop-term-shell "/bin/zsh")
  (shell-pop-universal-key "C-t") ;; platformio-ide-terminal key
  (shell-pop-window-height 30)
  (shell-pop-window-position "bottom"))


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(shell-pop auto-complete-chunk yasnippet which-key try neotree markdown-mode gruvbox-theme flycheck-inline ergoemacs-mode company auto-complete all-the-icons ace-window)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
