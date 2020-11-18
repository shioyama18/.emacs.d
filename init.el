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
(require 'package)

(add-to-list 'package-archives
      '("melpa" . "http://melpa.org/packages/") t)
(package-initialize)
;(package-refresh-contents)

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
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)

;; Show file size
(size-indication-mode t)

;; Don't show tool bar, scroll bar, and menu bar
(tool-bar-mode -1)
(scroll-bar-mode -1)
(menu-bar-mode -1)

;; yes or no => y or n
(defalias 'yes-or-no-p 'y-or-n-p)

;; Show full path of file in frame
(setq frame-title-format "%f")

;; Don't create backup files
(setq make-backup-files nil)

;; Delete auto save files when quitting
(setq delete-auto-save-files t)

;; Require newline at the end of file
(setq require-final-newline t)

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

;; Remap help
(global-set-key (kbd "M-?") 'help-command)

;; Delete word
(global-set-key (kbd "M-h") 'backward-kill-word)

;; Wrap long lines
(global-set-key (kbd "C-c t") 'toggle-truncate-lines)

;; Override buffer list
(global-set-key (kbd "C-x C-b") 'bs-show)

;; Kill up to certain character
(global-set-key (kbd "M-z") 'zop-up-to-char)

;;===========================================
;; User Defined Functions
;;===========================================
(defun other-window-or-split ()
  "Move to other window, or create one and then move if window does not exist."
  (interactive)
  (when (one-window-p) (split-window-vertically))
  (other-window 1))

(global-set-key (kbd "C-t") 'other-window-or-split)

;;===========================================
;; customize
;;===========================================
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file)

(require 'use-package)

;; ace-jump-mode
(use-package ace-jump-mode
      :commands ace-jump-mode
      :init
      (setq ace-jump-mode-move-keys (append "asdfghjkl;:]qwertyuiop@zxcvbnm,." nil))
      (setq ace-jump-word-mode-use-query-char nil)
      :bind (("C-q" . ace-jump-mode)))

;; bm
(use-package bm
  :ensure t
  :bind (("M-SPC" . bm-toggle)
         ("C-M-]" . bm-previous)
         ("C-M-[" . bm-next))
  :init
  (setq-default bm-buffer-persistence nil)
  (setq bm-restore-repository-on-load t)
  :config
  (add-hook 'find-file-hook 'bm-buffer-restore)
  (add-hook 'kill-buffer-hook 'bm-buffer-save)
  (add-hook 'after-save-hook 'bm-buffer-save)
  (add-hook 'after-revert-hook 'bm-buffer-restore)
  (add-hook 'vc-before-checkin-hook 'bm-buffer-save))

;; company
(use-package company
    :init
    (setq company-selection-wrap-around t)
    (setq company-idle-delay 0.1)
    (setq company-tooltip-align-annotations t)
    :config
    (global-company-mode))

;; yaml-mode
(use-package yaml-mode
  :ensure t
  :mode "\\.yml\\'")

;; yasnippet
(use-package yasnippet
  :ensure t
  :bind (("C-c i" . yas-insert-snippet)
         ("C-c n" . yas-new-snippet)
         ("C-c v" . yas-visit-snippet-file))
  :config
  (yas-global-mode t)
  (setq yas-prompt-functions '(yas-ido-prompt)))

;;===========================================
;; Rust
;;===========================================
;; Add path to racer, rustfmt, etc.
(add-to-list 'exec-path (expand-file-name "~/.cargo/bin"))

;; rustic
(use-package rustic
  :ensure t
  :defer t
  :mode ("\\.rs" . rustic-mode)
  :config
  (setq rustic-format-trigger 'on-save))

;;===========================================
;; Python
;;===========================================
(use-package elpy
  :ensure t
  :init
  (elpy-enable))

;;; init.el ends here
