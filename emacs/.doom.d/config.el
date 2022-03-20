;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.

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
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-tokyo-night)

; (setq doom-font (font-spec :family "SauceCodePro Nerd Font" :size 15))
(setq doom-font (font-spec :family "Source Code Pro" :size 15))

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(add-hook 'org-mode-hook '
          (lambda () (setq fill-column 80)))
(add-hook 'org-mode-hook 'auto-fill-mode)

(after! org
  (setq org-directory "~/Dropbox/Org/"
        ;; org-agenda-files '("~/Dropbox/Org/agenda.org")
        ;; org-default-notes-file (expand-file-name "notes.org" org-directory)
        org-ellipsis " ▼ "
        org-superstar-headline-bullets-list '("◉" "●" "○" "◆" "●" "○" "◆")
        org-superstar-item-bullet-alist '((?+ . ?➤) (?- . ?✦)) ; changes +/- symbols in item lists
        org-log-done 'time
        org-hide-emphasis-markers t
        ;; ex. of org-link-abbrev-alist in action
        ;; [[arch-wiki:Name_of_Page][Description]]
        org-link-abbrev-alist    ; This overwrites the default Doom org-link-abbrev-list
          '(("search" . "https://duckduckgo.com/?q=")
            ("arch-wiki" . "https://wiki.archlinux.org/index.php/")
            ("wiki" . "https://en.wikipedia.org/wiki/"))
        org-table-convert-region-max-lines 20000
        org-todo-keywords        ; This overwrites the default Doom org-todo-keywords
          '((sequence
             "TODO(t)"           ; A task that is ready to be tackled
             "BLOG(b)"           ; Blog writing assignments
             "GYM(g)"            ; Things to accomplish at the gym
             "PROJ(p)"           ; A project that contains other tasks
             "VIDEO(v)"          ; Video assignments
             "WAIT(w)"           ; Something is holding up this task
             "|"                 ; The pipe necessary to separate "active" states and "inactive" states
             "DONE(d)"           ; Task has been completed
             "CANCELLED(c)" )))) ; Task has been cancelled

(custom-set-faces
  '(org-level-1 ((t (:inherit outline-1 :height 1.4))))
  '(org-level-2 ((t (:inherit outline-2 :height 1.3))))
  '(org-level-3 ((t (:inherit outline-3 :height 1.2))))
  '(org-level-4 ((t (:inherit outline-4 :height 1.1))))
  '(org-level-5 ((t (:inherit outline-5 :height 1.0))))
)

;; (setq org-export-with-toc nil)
;; (setq org-export-with-section-numbers nil)
(setq org-publish-project-alist
      '(("org-notes"
        :base-directory "~/Dropbox/Org/"
        :base-extension "org"
        :publishing-directory "~/Dropbox/Org/html/"
        :recursive t
        :exclude "org-html-themes/.*"
        :publishing-function org-html-publish-to-html
        :headline-levels 4
        :auto-preamble t)
        ))

;; tetris stuff
(defvar tetris-mode-map
  (make-sparse-keymap 'tetris-mode-map))

(define-key tetris-mode-map "n"     'tetris-start-game)
(define-key tetris-mode-map "q"     'tetris-end-game)
(define-key tetris-mode-map "p"     'tetris-pause-game)
(define-key tetris-mode-map " "     'tetris-move-bottom)
(define-key tetris-mode-map [left]  'tetris-move-left)
(define-key tetris-mode-map [right] 'tetris-move-right)
(define-key tetris-mode-map [up]    'tetris-rotate-prev)
(define-key tetris-mode-map [down]  'tetris-rotate-next)
