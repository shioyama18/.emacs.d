;;; init.el --- Initialization file for Emacs
;; Copyright (C) 2019 by Shion Yamashita
;; Author: Shion Yamashita <shioyama1118@gmail.com>
;; Version: 0.1
;;; Commentary:
;;; Emacs Startup File --- initialization for Emacs

;;; Code:

;;===========================================
;; Package Management
;;===========================================
(package-initialize)
(require 'package)
(add-to-list 'package-archives
      '("melpa" . "http://melpa.org/packages/") t)
       
;;===========================================
;; Basic Settings
;;===========================================
;; Don't show startup message
(setq inhibit-startup-message t)

;; Show row and column number
(line-number-mode t)
(column-number-mode t)

;; Remember the cursor
(save-place-mode t)

;; Lessen garbage collection
(setq gc-cons-threshold (* 10 gc-cons-threshold))

;; Turn off setting for language reading from right to left
(setq-default bidi-display-reordering nil)

;; Fasten keystrokes
(setq echo-keystrokes 0.1)

;; Remove beep sound
(setq ring-bell-function 'ignore)

;; Show the matching parenthesis
(show-paren-mode t)

;; Set tab width to 4 spaces
(setq-default tab-width 4)

;; Show file size
(size-indication-mode t)

;; Don't show tool bar and scroll bar
(tool-bar-mode nil)
(scroll-bar-mode nil)

;; yes or no => y or n
(defalias 'yes-or-no-p 'y-or-n-p)

;; Show full path of file in frame
(setq frame-title-format "%f")

;; Don't create backup files
(setq make-backup-files nil)

;; Delete auto save files when quitting
(setq delete-auto-save-files t)

;; Set color theme
(load-theme 'tango-dark t)

;; Enable recentf
(recentf-mode t)
(global-set-key (kbd "C-x C-r") 'recentf-open-files)

;; Enable ido
(ido-mode t)

;;===========================================
;; Keyboard Settings
;;===========================================
;; Delete character
(global-set-key (kbd "C-h") 'delete-backward-char)

;; Delete word
(global-set-key (kbd "M-h") 'backward-kill-word)

;; Wrap long lines
(global-set-key (kbd "C-c t") 'toggle-truncate-lines)

;; Switch to other window
(global-set-key (kbd "C-t") 'other-window)

;; Override buffer list
(global-set-key (kbd "C-x C-b") 'bs-show)

;; Kill up to certain character
(global-set-key (kbd "M-z") 'zop-up-to-char)

;;===========================================
;; customize
;;===========================================
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file)

;;===========================================
;; ace-jump-mode
;;===========================================
(use-package ace-jump-mode
      :commands ace-jump-mode
      :init
	  (setq ace-jump-mode-move-keys (append "asdfghjkl;:]qwertyuiop@zxcvbnm,." nil))
	  (setq ace-jump-word-mode-use-query-char nil)
	  :bind (("C-q" . ace-jump-mode))
	  )

;;===========================================
;; company
;;===========================================
(use-package company
    :init
    (setq company-selection-wrap-around t)
	(setq company-idle-delay 0.1)
	(setq company-tooltip-align-annotations t)
    :config
    (global-company-mode))

;;===========================================
;; yasnippet
;;===========================================
;; (use-package yasnippet
;;   :ensure t
;;   :diminish yas-minor-mode
;;   :bind (:map yas-minor-mode-map
;;               ("C-c i" . yas-insert-snippet)
;;               ("C-c n" . yas-new-snippet)
;;               ("C-c v" . yas-visit-snippet-file)
;;               ("C-x i l" . yas-describe-tables)
;;               ("C-x i g" . yas-reload-all))              
;;   :config
;;   (yas-global-mode t)
;;   (setq yas-prompt-functions '(yas-ido-prompt))
;;   )

(use-package yasnippet
  :ensure t
  :bind (("C-c i" . yas-insert-snippet)
		 ("C-c n" . yas-new-snippet)
		 ("C-c v" . yas-visit-snippet-file))
  :config
  (yas-global-mode t)
  (setq yas-prompt-functions '(yas-ido-prompt))
  )


;;===========================================
;; Rust
;;===========================================
(add-to-list 'exec-path (expand-file-name "~/.cargo/bin"))

;; rust-mode
(use-package rust-mode
  :defer t
  :config
  (setq rust-format-on-save t))

;; racer
(use-package racer
  :init
  (add-hook 'rust-mode-hook #'racer-mode)
  (add-hook 'racer-mode-hook #'eldoc-mode))

;; flycheck-rust
(use-package flycheck-rust
  :init
  (add-hook 'rust-mode-hook
            '(lambda ()
               (flycheck-mode)
               (flycheck-rust-setup))))

;;===========================================
;; Python
;;===========================================
(use-package elpy
  :ensure t
  :init
  (elpy-enable))

;;===========================================
;; Golang
;;===========================================
(use-package go-mode
  :ensure t
  :init
  ;; eldoc
  (add-hook 'go-mode-hook 'go-eldoc-setup)
  ;; flycheck
  (add-hook 'go-mode-hook 'flycheck-mode)  
  ;; gofmt
  (add-hook 'before-save-hook 'gofmt-before-save)
)

(use-package company-go
  :ensure t
  :defer t
  :init
  (with-eval-after-load 'company
    (add-to-list 'company-backends 'company-go)))



;;; init.el ends here
