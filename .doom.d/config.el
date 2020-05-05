;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; This directory has to be set before org is loaded
(setq org-directory "~/Dropbox/org/")
;; Load my configs
(require 'org)
(org-babel-load-file
 (expand-file-name "settings.org"
                   "~/.doom.d/"))
