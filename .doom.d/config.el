;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(require 'org)
(org-babel-load-file
 (expand-file-name "settings.org"
                   "~/.doom.d/"))
