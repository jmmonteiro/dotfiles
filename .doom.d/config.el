;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Joao M. Monteiro"
      user-mail-address "")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
(setq doom-font (font-spec :family "monospace" :size 14))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")
(setq org-agenda-files (directory-files-recursively "~/org/" "\.org$"))

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c g k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c g d') to jump to their definition and see how
;; they are implemented.
;;

; -----------------------------------------
; --- Projectile
; -----------------------------------------
(setq projectile-project-search-path '("~/git/"))

; -----------------------------------------
; --- Auto-complete
; -----------------------------------------
(use-package company
  :init (global-company-mode))
; Python
(use-package company-jedi
  :init (add-to-list 'company-backends 'company-jedi))
(use-package python
  :hook ((python-mode . jedi:setup)))

; -----------------------------------------
; --- Movement
; -----------------------------------------
;; Make evil-mode up/down operate in screen lines instead of logical lines
(define-key evil-motion-state-map "j" 'evil-next-visual-line)
(define-key evil-motion-state-map "k" 'evil-previous-visual-line)
;; Also in visual mode
(define-key evil-visual-state-map "j" 'evil-next-visual-line)
(define-key evil-visual-state-map "k" 'evil-previous-visual-line)

; Restore "s" to the standard vim behaviour
; https://github.com/hlissner/doom-emacs/issues/1307
(after! evil-snipe
  (evil-snipe-mode -1))

; -----------------------------------------
; --- Python
; -----------------------------------------
(setq gud-pdb-command-name "python -m pdb ")
; Autoformat on save
; Set M-x pdb command to use the virtualenv's python debugger
(add-hook 'python-mode-hook 'yapf-mode)
; Check linting
(add-hook 'python-mode-hook 'flycheck-mode)
; Sort imports
(add-hook 'before-save-hook 'py-isort-before-save)

; -----------------------------------------
; --- Spelling
; -----------------------------------------
(add-hook 'org-mode-hook 'turn-on-flyspell)
(add-hook 'LaTeX-mode-hook 'turn-on-flyspell)
(add-hook 'markdown-mode-hook 'turn-on-flyspell)

; -----------------------------------------
; --- Org-mode
; -----------------------------------------

; Custom status/colors
(after! org
(setq org-todo-keywords
      '((sequence "TODO(t!)" "BLOCKED(b@/!)"  "|" "DONE(d!)" "CANCELED(c@)" "DELEGATED(o@/!)")))

  (setq org-todo-keyword-faces
        (quote (("TODO" :foreground "#74c95d" :weight bold)
                ("BLOCKED" :foreground "#cc6666" :weight bold)
                ("DONE" :foreground "#808080" :weight bold)
                ("CANCELLED" :foreground "#f0c674" :weight bold)
                ("DELEGATED" :foreground "#b294bb" :weight bold))))

)

;; Org-crypt
(require 'org-crypt)
(org-crypt-use-before-save-magic)
(setq org-tags-exclude-from-inheritance (quote ("crypt")))

(setq org-crypt-key "7C7C1C77")
  ;; GPG key to use for encryption
  ;; Either the Key ID or set to nil to use symmetric encryption.


;; Org-ref
(require 'org-ref)
(setq reftex-default-bibliography '("~/org/ref.bib"))
(setq org-ref-pdf-directory "~/Documents/papers/")

; Custom org-mode states
(setq alert-default-style 'libnotify)

; Display start of agenda to today
(setq org-agenda-start-day "0d")

; -- super-agenda
(setq org-super-agenda-header-map (make-sparse-keymap))
(setq spacemacs-theme-org-agenda-height nil
      ;; org-agenda-time-grid '((daily today require-timed) "----------------------" nil)
      org-agenda-skip-scheduled-if-done t
      org-agenda-skip-deadline-if-done t
      org-agenda-include-deadlines t
      org-agenda-include-diary t
      org-agenda-block-separator nil
      org-agenda-compact-blocks t
      org-agenda-start-with-log-mode t)
(setq org-agenda-custom-commands
      '(("z" "Super zoom view"
         ((agenda "" ((org-agenda-span 'day)
                      (org-super-agenda-groups
                       '((:name "Today"
                                :time-grid t
                                :date today
                                :todo "TODAY"
                                :scheduled today
                                :order 1)))))
          (alltodo "" ((org-agenda-overriding-header "")
                       (org-super-agenda-groups
                        '((:name "Next to do"
                                 :todo "NEXT"
                                 :order 1)
                          (:name "Important"
                                 :tag "Important"
                                 :priority "A"
                                 :order 6)
                          (:name "Due Today"
                                 :deadline today
                                 :order 2)
                          (:name "Due Soon"
                                 :deadline future
                                 :order 8)
                          (:name "Overdue"
                                 :deadline past
                                 :order 7)
                          (:name "Waiting"
                                 :todo "WAIT"
                                 :order 20)
                          (:name "Regular work"
                                 :priority "B"
                                 :order 10)
                          (:name "Someday"
                                 :priority<= "C"
                                 :tag ("Trivial" "Unimportant")
                                 :todo ("SOMEDAY" )
                                 :order 90)
                          (:discard (:tag ("Chore" "Routine" "Daily")))))))))))
(org-super-agenda-mode)
