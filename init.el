;;; package -- summary
;;; Commentary:
;; My Emacs config that includes extra packages for org mode and stuff
;;; Code:
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(initial-frame-alist (quote ((fullscreen . maximized))))
 '(package-selected-packages
   (quote
    (neotree dired-sidebar php-mode openwith diff-hl org-plus-contrib haskell-mode go-mode auto-complete use-package))))
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

;; Installs melpa and use-package
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
(package-initialize)
(setq package-enable-at-startup nil)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(when (not (package-installed-p 'use-package))
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package-ensure)
(setq use-package-always-ensure t)
(use-package auto-compile
  :config (auto-compile-on-load-mode))

(setq load-prefer-newer t)
(setq package-check-signature nil)

;; Set me
(setq user-full-name "Paul J. Hutchison"
      user-mail-address "p@ulhutchison.co.uk")

;; Org configurations
(load-file "~/.emacs.d/org-config.el")

;; Install Extra modes
(use-package haskell-mode
  :ensure t
  :mode ("\\.hs$" . haskell-mode))
(use-package go-mode
  :ensure t
  :mode ("\\.go$" . go-mode))
(use-package php-mode
  :ensure t
  :mode ("\\.php$" . php-mode))

;; Add good auto-completion
(use-package auto-complete
  :ensure t
  :init
  (progn
    (ac-config-default)
    (global-auto-complete-mode t)
    ))

;; Themes
(use-package darkokai-theme
  :ensure t
  :init
  )
(load-theme' darkokai t)

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
(setq-default c-basic-offset 4)

;; Stops back-ups and save files
(setq make-backup-files nil)
(setq auto-save-default nil)

;; Turn off the bell sound and give a visual bell instead
(setq visible-bell 1)

;; Changes the way the editor looks
(tool-bar-mode -1) ;; minimal
(menu-bar-mode -1)

;; Change the default font size
(set-face-attribute 'default nil :height 110)

;; Add full word wrap
(global-visual-line-mode t)

;; Changing command keys
(global-set-key (kbd "C-x r") 'revert-buffer)
;;     Start of buffer
(global-set-key (kbd "M-,") 'beginning-of-buffer)
(global-unset-key (kbd "M-<"))
;;     End of buffer
(global-set-key (kbd "M-.") 'end-of-buffer)
(global-unset-key (kbd "M->"))
;;     Adding a key for opening a file in sudo
(global-set-key (kbd "C-x C-'") #'er-sudo-edit)
;; More convenient commands to change frame size
(global-set-key (kbd "C-(") 'shrink-window-horizontally)
(global-set-key (kbd "C-)") 'enlarge-window-horizontally)
(global-set-key (kbd "C-_") 'shrink-window)
(global-set-key (kbd "C-+") 'enlarge-window)

;; change the caret type
(setq-default cursor-type 'bar)
(blink-cursor-mode 0)
(setq-default cursor-in-non-selected-windows nil)

;; Highlight uncommitted changed
(use-package diff-hl
  :config
  (add-hook 'prog-mode-hook 'turn-on-diff-hl-mode)
  (add-hook 'vc-dir-mode-hook 'turn-on-diff-hl-mode))
(global-diff-hl-mode)

;; Open pdfs with evince instead
(use-package openwith
  :custom
  (openwith-associations '(("\\.pdf\\'" "evince" (file))))
  :config
  (openwith-mode t))

(use-package all-the-icons)

(use-package neotree
  :ensure t
  :bind (("<f2>" . neotree-toggle))
  :defer
  :init
  (bind-key "C-# c" 'neotree-create-node)
  (bind-key "C-# r" 'neotree-rename-node)
  (bind-key "C-# d" 'neotree-delete-node)
  (bind-key "C-# j" 'neotree-next-node)
  (bind-key "C-# k" 'neotree-previous-node)
  (bind-key "C-# g" 'neotree-refresh)
  (bind-key "C-# C" 'neotree-change-root)
  (bind-key "C-# h" 'neotree-hidden-file-toggle)
  (bind-key "C-# q" 'neotree-hide)
  (bind-key "C-# l" 'neotree-enter))

(setq neo-theme (if (display-graphic-p) 'icons 'arrow))

;; flycheck
(use-package flycheck
  :ensure t
  :init (global-flycheck-mode)
  :diminish flycheck-mode)
(provide 'init)
;;; init.el ends here
