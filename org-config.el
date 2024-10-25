;;; package -- summary
;;; Commentary:
;; Install org and apply key binding for refiling
;;; Code:
(use-package org
  :mode (("\\.org$" . org-mode))
  :ensure org-plus-contrib
  :bind-keymap ("C-c C-x C-s" . mark-done-and-archive))

;; Useful Functions
(defun org-file-path (filename)
  "Return the absolute address of an org file, given its FILENAME."
  (concat (file-name-as-directory org-directory) filename))

(defun mark-done-and-archive ()
  "Mark the state of an 'org-mode' item as DONE and archive it."
  (interactive)
  (org-todo 'done)
  (org-archive-subtree))

;; Setting key bindings
(global-set-key (kbd "C-c l") 'org-store-link)
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c c") 'org-capture)
(global-set-key (kbd "C-c o") (lambda() (interactive)(find-file org-default-notes-file)))

;; Key binding for archiving TODOs
;; (define-key org-mode-map (kbd "C-c C-x C-s") 'mark-done-and-archive)

;; Org Based Variables
(setq org-log-done 'time)
(setq org-ellipsis "↴")
(setq org-directory "C:/org")
(setq org-default-notes-file (org-file-path "todo.org"))
(setq org-archive-location
      (concat (org-file-path "archive.org") "::* From %s"))
2
;; Org babel
(org-babel-do-load-languages 'org-babel-load-languages '((shell . t)))
(org-babel-do-load-languages 'org-babel-load-languages '((python . t)))

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
;;; org-config.el ends here

