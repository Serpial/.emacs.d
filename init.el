;; Automatic Stuff
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(initial-frame-alist (quote ((fullscreen . maximized))))
 '(package-selected-packages
   (quote
    (srcery-theme haskell-mode d-mode go-mode T markdown-mode auto-complete use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;;;;;;;;;;;;;
;; My Changes
;;;;;;;;;;;;;;

;; Use M-x eval-buffer to refresh emacs

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

;; Install Extra modes
;;     D-mode
(use-package d-mode
  :ensure t
  :mode ("\\.d$" . d-mode))
(use-package haskell-mode
  :ensure t
  :mode ("\\.hs$" . haskell-mode))
(use-package go-mode
  :ensure t
  :mode ("\\.go$" . go-mode))

;; Add good auto-completion
(use-package auto-complete
  :ensure t
  :init
  (progn
    (ac-config-default)
    (global-auto-complete-mode t)
    ))

;; Themes
(use-package srcery-theme
  :ensure t
  :init
  )
(load-theme' srcery t)

;; Function for reopening the file in sudo mode
(defun er-sudo-edit (&optional arg)
  (interactive "P")
  (if (or arg (not buffer-file-name))
      (find-file (concat "/sudo:root@localhost:"
                         (ido-read-file-name "Find file(as root): ")))
      (find-alternate-file (concat "/sudo:root@localhost:" buffer-file-name))))

;; Stops the startup screen from showing
(setq inhibit-startup-screen t)

;; add line numbers at side of screen
(global-linum-mode t)
;;     disable linum mode when in shell
(add-hook 'shell-mode-hook (lambda () (linum-mode -1))) 

;; Automatically close braces and stuff
(electric-pair-mode 1)

;; Turn tabs into spaces
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)

;; Stops back-ups and save files
(setq make-backup-files nil)
(setq auto-save-default nil)

;; Changes the way the editor looks
(tool-bar-mode -1) ;; minimal

;; Change the default font size
(set-face-attribute 'default nil :height 110)

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
;;     Adding a key for opening a file in sudo
(global-set-key (kbd "C-x C-'") #'er-sudo-edit)

;; make emacs semi-transparent
(set-frame-parameter (selected-frame) 'alpha '(90 . 93))
(add-to-list 'default-frame-alist '(alpha . (90 . 93)))

;; change the caret type
(setq-default cursor-type 'bar)
(blink-cursor-mode 0)
(setq-default cursor-in-non-selected-windows nil)
