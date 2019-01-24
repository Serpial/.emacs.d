;; Automatic Stuff
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(initial-frame-alist (quote ((fullscreen . maximized))))
 '(package-selected-packages
   (quote
    (go-mode haskell-mode helm-ag helm-swoop helm-descbinds helm d-mode T markdown-mode auto-complete use-package))))
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

;; Helm stuff
(use-package helm
  :ensure t
  :bind (("M-a" . helm-M-x)
         ("C-x C-f" . helm-find-files)
         ("C-x f" . helm-recentf)
         ("C-M-SPC" . helm-dabbrev)
         ("M-y" . helm-show-kill-ring)
         ("C-x b" . helm-buffers-list))
  :bind (:map helm-map
              ("M-i" . helm-previous-line)
              ("M-k" . helm-next-line)
              ("M-I" . helm-previous-page)
              ("M-K" . helm-next-page)
              ("M-h" . helm-beginning-of-buffer)
              ("M-H" . helm-end-of-buffer))
  :config (progn
            (setq helm-buffers-fuzzy-matching t)
            (helm-mode 1)))
(use-package helm-descbinds
  :ensure t
  :bind ("C-h b" . helm-descbinds))
(use-package helm-files
  :bind (:map helm-find-files-map
              ("M-i" . nil)
              ("M-k" . nil)
              ("M-I" . nil)
              ("M-K" . nil)
              ("M-h" . nil)
              ("M-H" . nil)))
(use-package helm-swoop
  :ensure t
  :bind (("M-m" . helm-swoop)
         ("M-M" . helm-swoop-back-to-last-point))
  :init
  (bind-key "M-m" 'helm-swoop-from-isearch isearch-mode-map))
(use-package helm-ag
  :ensure helm-ag
  :bind ("M-p" . helm-projectile-ag)
  :commands (helm-ag helm-projectile-ag)
  :init (setq helm-ag-insert-at-point 'symbol
              helm-ag-command-option "--path-to-ignore ~/.agignore"))

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
