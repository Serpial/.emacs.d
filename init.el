;; Automatic Stuff
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages (quote (auto-complete use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;;;;;;;;;;;;;
;; My Changes
;;;;;;;;;;;;;;

;; Set home directory
;; (cd "L:\\") ;; Windows Only

;; Installs melpa and use-package
(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives
             '("melpa-stable" . "http://melpa.org/packages/") t)
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Add good auto-completion
(use-package auto-complete
  :ensure t
  :init
  (progn
    (ac-config-default)
    (global-auto-complete-mode t)
    ))

(use-package monokai-theme
	:ensure t
	:init
	)

(load-theme 'monokai t)

;; Stops the startup screen from showing
(setq inhibit-startup-screen t)

;; add line numbers at side of screen
(global-linum-mode t)

;; Automatically close braces and stuff
(electric-pair-mode 1)

;; Turn tabs into spaces
(setq-default indent-tabs-mode)

;; Stops back-ups and save files
(setq make-backup-files nil)
(setq auto-save-default nil)

;; Changes the way the editor looks
(tool-bar-mode -1)

;; Add full word wrap
(global-visual-line-mode t)

;; make emacs semi-transparent
(set-frame-parameter (selected-frame) 'alpha '(92 . 95))
(add-to-list 'default-frame-alist '(alpha . (92 . 95)))
