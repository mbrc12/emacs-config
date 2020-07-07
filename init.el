(setq inhibit-splash-screen t)
(tool-bar-mode -1)
(toggle-scroll-bar -1)
(add-to-list 'default-frame-alist
	     '(vertical-scroll-bars . nil))
(menu-bar-mode -1)
(show-paren-mode 1)

(setq scroll-step 1)

(setq-default tab-width 4)
(setq indent-tabs-mode nil)

(add-to-list 'default-frame-alist
	     '(fullscreen . maximized))

(add-hook 'after-init-hook 'global-display-line-numbers-mode)
(global-hl-line-mode 1)

;; Do not litter this init.el
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

(load-file "~/.emacs.d/move-border.el")

(setq split-width-threshold 1)
(setq split-height-threshold nil)

;; Wrapping enabled
(setq-default truncate-lines 1)

(defun commenter ()
  ;; Comments a selected line, see binding for ";" in evil package usage.
    (interactive)
    (comment-or-uncomment-region
     (line-beginning-position)
     (line-end-position))
    (forward-line))



;; For straight.el -- package management
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

;; Load use-package
(straight-use-package 'use-package)

;;;;;;

(use-package sudo-edit
  :straight t)

;;;;;;
(use-package flycheck
  :straight t
  
  :hook
  ((prog-mode . flycheck-mode)))

;;;;;;

(use-package company
  :straight t

  :init
  (setq company-idle-delay 0)
  (setq company-minimum-prefix-length 1)

  :config
  (add-to-list 'company-backends 'company-dabbrev t)
  
  :hook
  ((after-init . global-company-mode)))

;;;;;;

;; (use-package kaolin-themes
;;   :straight t
;;   :config
;;   (load-theme 'kaolin-aurora t))

(use-package doom-themes
  :straight t
  :config
  (load-theme 'doom-nord-light t))

;;;;;;

(use-package smartparens
  :straight t

  :config
  (smartparens-global-mode t))

;;;;;;

(use-package evil
  :straight t

  :init
  (setq evil-want-keybinding nil)

  :config
  (evil-mode 1)
  (define-key evil-normal-state-map (kbd "-ec") '(lambda ()
                                                   (interactive)
                                                   (find-file "~/.emacs.d/init.el")))
  (define-key evil-normal-state-map (kbd "-rl") '(lambda ()
                                                    (interactive)
                                                    (load-file buffer-file-name)))
  (define-key evil-normal-state-map (kbd "-pp") 'projectile-switch-project)
  (define-key evil-normal-state-map (kbd "-tt") 'treemacs)
  (define-key evil-normal-state-map (kbd "-TT") 'treemacs-projectile)
  (define-key evil-normal-state-map (kbd "M-q") 'delete-other-windows)
  (define-key evil-normal-state-map (kbd "M-w") 'delete-window)
  (define-key evil-normal-state-map (kbd ";") 'commenter)
  (define-key evil-visual-state-map (kbd ";") 'comment-or-uncomment-region)
  (define-key evil-normal-state-map (kbd "]]") 'move-border-right)
  (define-key evil-normal-state-map (kbd "[[") 'move-border-left)
  (define-key evil-normal-state-map (kbd "--h") 'split-window-horizontally)
  (define-key evil-normal-state-map (kbd "--v") 'split-window-vertically)
  (evil-ex-define-cmd "q" 'kill-this-buffer)
  (evil-ex-define-cmd "quit" 'evil-quit))

;;;;;;

(use-package evil-collection
  :straight t

  :config
  (evil-collection-init))

;;;;;;

(use-package ivy
  :straight t

  :config
  (ivy-mode 1))

;;;;;;

(use-package smex
  :straight t

  :config
  (smex-initialize)
  (global-set-key (kbd "M-x") 'smex))

;;;;;;

(use-package lsp-mode
  :straight t

  :init
  (setq lsp-pyls-server-command "/home/mbrc/Software/Anaconda/anaconda3/bin/pyls")

  :commands
  lsp
  
  :hook
  ((rust-mode . lsp)
   (python-mode . lsp)))


;;;;;;

(use-package clojure-mode
  :straight t)

;;;;;;

(use-package cider
  :straight t

  :config
  
  (evil-define-key 'normal cider-mode-map (kbd "-eb") 'cider-eval-buffer)
  (evil-define-key 'normal cider-mode-map (kbd "-en") 'cider-eval-ns-form)
  (evil-define-key 'normal cider-mode-map (kbd "-er") 'cider-eval-region)
  (evil-define-key 'normal cider-mode-map (kbd "-i") 'cider-interrupt)
  (evil-define-key 'normal cider-mode-map (kbd "-d") 'cider-doc)
  (evil-define-key 'normal cider-mode-map (kbd "-ee") 'cider-eval-last-sexp))

;;;;;;

(use-package fish-mode
  :straight t)

;;;;;;

(use-package lsp-ivy
  :straight t
  :commands lsp-ivy-workspace-symbol)

;;;;;;

(use-package treemacs
  :straight t)

;;;;;;

(use-package lsp-treemacs
  :straight t
  :commands lsp-treemacs-errors-list)

;;;;;;

(use-package treemacs-evil
  :straight t)

;;;;;;

(use-package projectile
  :straight t
  :config
  (projectile-add-known-project "~/dev/jst"))

;;;;;;

(use-package treemacs-projectile
  :straight t)

;;;;;;

(use-package lsp-ui
  :straight t

  :commands
  lsp-ui-mode
  
  :config
  (lsp-ui-peek-enable t)
  (lsp-ui-doc-enable t)
  (setq lsp-ui-sideline-show-diagnostics t)
  (setq lsp-ui-sideline-show-hover t)
  (setq lsp-ui-sideline-show-symbol t))

;;;;;;

(use-package company-lsp
  :straight t)

;;;;;; --- Modeline configuration

(use-package telephone-line
  :straight t

  :config
  (setq telephone-line-primary-left-separator 'telephone-line-cubed-left
        telephone-line-secondary-left-separator 'telephone-line-cubed-hollow-left
        telephone-line-primary-right-separator 'telephone-line-cubed-right
        telephone-line-secondary-right-separator 'telephone-line-cubed-hollow-right)
  (setq telephone-line-height 30)
  (setq telephone-line-lhs
        '((evil . (telephone-line-evil-tag-segment))
          (accent . (telephone-line-vc-segment
                      telephone-line-erc-modified-channels-segment
                      telephone-line-process-segment))
          (nil . (telephone-line-buffer-segment))))

  (setq telephone-line-rhs
        '((nil . (telephone-line-misc-info-segment
				  telephone-line-minor-mode-segment))
          (accent . (telephone-line-major-mode-segment))
          (evil . (telephone-line-airline-position-segment))))

  (telephone-line-mode 1))
