(require 'use-package)
(package-initialize)
(menu-bar-mode -1) ;; Whether to show it. (t for true, -1 for nil.)

(setq package-archives
      ;; copied from https://babbagefiles.xyz/org-roam-on-android/
      '(("Org" . "https://orgmode.org/elpa/")
	("Elpa"         . "https://elpa.gnu.org/packages/")
        ("Melpa Stable" . "https://stable.melpa.org/packages/")
        ("Melpa"        . "https://melpa.org/packages/")))
(setq package-archive-priorities
      '(("Org" . 20)
        ("Melpa"        . 15)
        ("Melpa Stable" . 10)
        ("Elpa"         . 5)))

(use-package emacsql-sqlite3 :ensure t)

;; org-roam

(require 'org-roam)
(setq org-roam-database-connector 'sqlite3)
(use-package org-roam
  :ensure t
  :hook
  (after-init . org-roam-mode)
  :custom
  (setq org-roam-db-location (file-truename "~"))
  (org-roam-directory (file-truename "~/org-roam/")))

(setq org-roam-v2-ack t) ;; indicates I migrated


(org-roam-db-autosync-mode)
(org-roam-directory "/home/jeff/org-roam")

;; TODO: A lot of global-set-key commands in this file use the wrong syntax,
;; omitting the # symbol. This way works.
;; (So does the lambda expression way, but it's needlessly verbose.)
(global-set-key (kbd "C-c C-l") #'org-insert-link)
(global-set-key (kbd "C-c n l") #'org-store-link)
(setq org-id-link-to-org-use-id t) ;; make stored links refer to IDs
(global-set-key (kbd "C-c n f") #'org-roam-node-find)
(global-set-key (kbd "C-c n i") #'org-roam-node-insert) ;; insert a *link*
(global-set-key (kbd "C-c n d") #'org-roam-db-sync) ;; update the db
(global-set-key (kbd "C-c n b") #'org-roam-buffer-toggle) ;; show backlinks

(setq org-roam-capture-templates
      ;; These folder names are dumb, but to change them I would need
      ;; to change every link involving them.
      '( ("u" "public" plain "%?"
          :if-new (file+head "tech/${slug}.org"
                             "#+title: ${title}\n")
          :unnarrowed t)
("r" "private" plain "%?"
          :if-new (file+head "pers/${slug}.org"
                             "#+title: ${title}\n")
          :unnarrowed t)
("o" "ofiscal" plain "%?"
          :if-new (file+head "ofiscal/${slug}.org"
                             "#+title: ${title}\n")
          :unnarrowed t)
))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(org-roam use-package)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

