;;; package -- summary
;;; Commentary:
;; My Emacs config that includes extra packages for org mode and stuff
;;; Code:
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(flycheck neotree all-the-icons diff-hl auto-le dired-sidebar openwith org-contrib use-package)))
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
(package-initialize)
(setq package-enable-at-startup nil)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(when (not (package-installed-p 'use-package))
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package-ensure)
(setq use-package-always-ensure t)
(use-package auto-compile
  :ensure t
  :config
  (auto-compile-on-load-mode))

(setq load-prefer-newer t)
(setq package-check-signature nil)

;; Set me
(setq user-full-name "Paul J. Hutchison"
      user-mail-address "p@ulhutchison.co.uk")

;; Set default directory
;; (setq default-directory "~/")
(setq default-directory "C:/")

;; Minimalistic modeline
(use-package diminish
  :ensure t)

;; Install Extra modes
;;(use-package go-mode
;;  :ensure t
;;  :mode ("\\.go$" . go-mode))

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
  :init)
(load-theme 'darkokai t)

;; Function for reopening the file in sudo mode
(defun er-sudo-edit (&optional arg)
  "Takes ARG that is associated with the file in which we call the function."
  (interactive "P")
  (if (or arg (not buffer-file-name))
      (find-file (concat "/sudo:root@localhost:"
                         (ido-read-file-name "Find file(as root): ")))
      (find-alternate-file (concat "/sudo:root@localhost:" buffer-file-name))))

;; Stops the startup screen from showing
(setq inhibit-startup-screen t)

;; add line numbers at side of screen
(global-display-line-numbers-mode t)
;;     disable line numbers when in shell
(dolist (hook '(shell-mode-hook
                eshell-mode-hook
                term-mode-hook
                comint-mode-hook))  ; comint-mode is a parent mode for interactive shells
  (add-hook hook (lambda () (display-line-numbers-mode -1))))

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
(global-set-key (kbd "C-{") 'shrink-window-horizontally)
(global-set-key (kbd "C-}") 'enlarge-window-horizontally)
(global-set-key (kbd "C-_") 'shrink-window)
(global-set-key (kbd "C-+") 'enlarge-window)
;; Use capital O to go back a frame
(global-set-key (kbd "C-x O") 'previous-multiframe-window)

;; change the caret type
(setq-default cursor-type '(box . size))
(blink-cursor-mode 0)
(setq-default cursor-in-non-selected-windows nil)

;; Highlight uncommitted changed
(use-package diff-hl
  :hook ((prog-mode vc-dir-mode) . diff-hl-mode)
  :config
  (global-diff-hl-mode 1))

;; Open pdfs with evince instead
(use-package openwith
  :custom
  (openwith-associations '(("\\.pdf\\'" "evince" (file))))
  :config
  (openwith-mode t))

(use-package all-the-icons
  :ensure t)
;; M-x all-the-icons-install-fonts

(use-package neotree
  :ensure t
  :bind (("<f2>" . neotree-toggle))
  :defer
  :init)

(setq neo-theme (if (display-graphic-p) 'icons 'arrow))

;; flycheck
(use-package flycheck
  :ensure t
  :defer 2
  :diminish
  :init (global-flycheck-mode)
  :custom
  (flycheck-display-errors-delay 0.3))
(provide 'init)

;; Install org and apply key binding for refiling
;;; Code:
(use-package org
  :mode (("\\.org$" . org-mode))
  :ensure org-contrib
  :config
  (define-key org-mode-map (kbd "C-c C-x C-s") 'mark-done-and-archive)
  (global-set-key (kbd "C-c l") 'org-store-link)
  (global-set-key (kbd "C-c a") 'org-agenda)
  (global-set-key (kbd "C-c c") 'org-capture)
  (global-set-key (kbd "C-c o") (lambda() (interactive)(find-file org-default-notes-file))))

;; Useful Functions
(defun org-file-path (filename)
  "Return the absolute address of an org file, given its FILENAME."
  (concat (file-name-as-directory org-directory) filename))

(defun mark-done-and-archive ()
  "Mark the state of an todo item as DONE and archive it."
  (interactive)
  (org-todo 'done)
  (org-archive-subtree))

;; Org Based Variables
(setq org-log-done 'time)
(setq org-ellipsis "↴")
(setq org-directory "C:/org-notes")
(setq org-default-notes-file (org-file-path "todo.org"))
(setq org-archive-location
      (concat (org-file-path "archive.org") "::* From %s"))

;; Org babel
(org-babel-do-load-languages 'org-babel-load-languages '((shell . t) (python . t)))

;; Org capture
(defvar org-export-coding-system)
(setq org-export-coding-system 'utf-8)
(defvar org-capture-templates)
(setq org-capture-templates
      '(("t" "Personal Todo" entry (file+headline org-default-notes-file
                                                       "Personal")
         "* TODO %?\nCREATED : %T %i\n %a")
        ("u" "Work Todo" entry (file+headline org-default-notes-file
                                                    "Work")
         "* TODO %?\nCREATED : %T %i\n %a")
        ))
;;; init.el ends here
