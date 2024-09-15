
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
(setq package-enable-at-startup nil)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

;; Instalar e configurar o `use-package`
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)

;;dashboard
(use-package dashboard
  :ensure t
  :init
  (setq dashboard-startup-banner 'official) ;; Exibe o banner padrão do Emacs
  (setq dashboard-set-heading-icons t)
  (setq dashboard-set-file-icons t)
  (setq initial-buffer-choice (lambda () (get-buffer "*dashboard*"))) ;; Força o dashboard como buffer inicial

  ;; Função para verificar se Emacs foi aberto em um diretório (emacs .)
  (defun my-dashboard-condition ()
    (let ((args (cdr command-line-args)))
      (and (= (length args) 1)
           (file-directory-p (car args)))))

  :config
  (dashboard-setup-startup-hook)

  ;; Função para abrir o dashboard e ajustar a exibição
  (defun my-open-dashboard ()
    (interactive)
    (if (get-buffer "*dashboard*")
        (switch-to-buffer "*dashboard*")
      (let ((dashboard-items
             (if (my-dashboard-condition)
                 '() ;; Exibir apenas "agenda" ao abrir o Emacs em um diretório
               '((recents  . 5)
                 (bookmarks . 5)
                 (projects . 5)
                 (agenda . 5)
                 (registers . 5))))) ;; Exibir todas as seções normalmente
        (dashboard-refresh-buffer))))

  ;; Hook para abrir o dashboard automaticamente e ajustar as seções
  (add-hook 'emacs-startup-hook 'my-open-dashboard))


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
  (setq neo-theme (if (display-graphic-p) 'icons 'arrow))
  (add-hook 'neo-after-create-hook
            (lambda (&rest _) (display-line-numbers-mode -1))))

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
(use-package company-jedi
  :ensure t
  :config
  (add-hook 'python-mode-hook
            (lambda ()
              (add-to-list 'company-backends 'company-jedi))))

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


(use-package centaur-tabs
  :ensure t
  :demand
  :config
  (progn
    (centaur-tabs-mode t)
    (centaur-tabs-headline-match)
    (setq centaur-tabs-style "bar")
    (setq centaur-tabs-set-bar 'over)
    (setq centaur-tabs-set-modified-marker t)
    (setq centaur-tabs-modified-marker "⏺")
    (centaur-tabs-change-fonts "arial" 100)
    (setq centaur-tabs-set-icons t)
    (setq centaur-tabs-height 32))
  :bind
  ("C-<prior>" . centaur-tabs-backward)
  ("C-<next>" . centaur-tabs-forward))


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("871b064b53235facde040f6bdfa28d03d9f4b966d8ce28fb1725313731a2bcc8" "046a2b81d13afddae309930ef85d458c4f5d278a69448e5a5261a5c78598e012" "98ef36d4487bf5e816f89b1b1240d45755ec382c7029302f36ca6626faf44bbd" "ba323a013c25b355eb9a0550541573d535831c557674c8d59b9ac6aa720c21d3" default))
 '(package-selected-packages
   '(shell-pop auto-complete-chunk yasnippet which-key try neotree markdown-mode gruvbox-theme flycheck-inline ergoemacs-mode company auto-complete all-the-icons ace-window)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
