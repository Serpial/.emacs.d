;; Automatic Stuff
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages (quote (markdown-mode auto-complete use-package))))
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
(tool-bar-mode -1) ;; minimal
(custom-set-variables
 '(initial-frame-alist (quote ((fullscreen . maximized)))))


;; Change the default font size
(set-face-attribute 'default nil :height 80)

;; Add full word wrap
(global-visual-line-mode t)

;; Changing command keys
;;     Changing other window to C-#
(global-set-key (kbd "C-#") 'other-window)
;; (global-unset-key (kbd "C-x o"))
;;     Start of buffer
(global-set-key (kbd "M-,") 'beginning-of-buffer)
(global-unset-key (kbd "M-<"))
;;     End of buffer
(global-set-key (kbd "M-.") 'end-of-buffer)
(global-unset-key (kbd "M->"))


;; make emacs semi-transparent
(set-frame-parameter (selected-frame) 'alpha '(92 . 95))
(add-to-list 'default-frame-alist '(alpha . (92 . 95)))
