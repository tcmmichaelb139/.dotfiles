(setq-default delete-by-moving-to-trash t                      ; Delete files to trash
              window-combination-resize t                      ; take new window space from all other windows (not just current)
              x-stretch-cursor t                              ; Stretch cursor to the glyph width
              tab-width 4)

;; defaults
(setq user-full-name "Michael Bao"
      doom-theme 'doom-tokyo-night
      doom-font (font-spec :family "FiraCode Nerd Font" :size 14)
      ;; setq doom-font (font-spec :family "SauceCodePro Nerd Font" :size 15)
      display-line-numbers-type 'relative
      truncate-string-ellipsis "…"                ; Unicode ellispis are nicer than "...", and also save /precious/ space
      undo-limit 80000000)                         ; Raise undo-limit to 80Mb

;; windows
(setq evil-vsplit-window-right t
      evil-split-window-below t)

;; centaur tabs


(after! centaur-tabs
  (centaur-tabs-group-by-projectile-project) ;;for https://github.com/ema2159/centaur-tabs/issues/181#issuecomment-1075806796
  (centaur-tabs-headline-match)
  (setq centaur-tabs-style "wave"
        centaur-tabs-height 24
        centaur-tabs-set-icons t
        centaur-tabs-gray-out-icons 'buffer
        centaur-tabs-set-bar 'under
        x-underline-at-descent-line t
        centaur-tabs-close-button "×"
        centaur-tabs-modified-marker "•"
        centaur-tabs-show-new-tab-button nil
        centaur-tabs-show-count t
        centaur-tabs-show-navigation-buttons t)
  (defun centaur-tabs-hide-tab (x)
    "Do no to show buffer X in tabs."
    (let ((name (format "%s" x)))
      (or
       ;; Current window is not dedicated window.
       (window-dedicated-p (selected-window))

       ;; Buffer name not match below blacklist.
       (string-prefix-p "*epc" name)
       (string-prefix-p "*helm" name)
       (string-prefix-p "*Helm" name)
       (string-prefix-p "*Compile-Log*" name)
       (string-prefix-p "*lsp" name)
       (string-prefix-p "*company" name)
       (string-prefix-p "*Flycheck" name)
       (string-prefix-p "*tramp" name)
       (string-prefix-p " *Mini" name)
       (string-prefix-p "*help" name)
       (string-prefix-p "*straight" name)
       (string-prefix-p " *temp" name)
       (string-prefix-p "*Help" name)
       (string-prefix-p "*mybuf" name)

       (string-prefix-p "*doom" name)
       (string-prefix-p "*scratch*" name)
       (string-prefix-p "*Messages" name)
       (string-prefix-p "*clangd" name)
       (string-prefix-p "*clangd::stderr" name)

       ;; Is not magit buffer.
       (and (string-prefix-p "magit" name)
            (not (file-name-extension name)))
       )))
  (map! :map evil-normal-state-map
        "t n" #'centaur-tabs-forward
        "t p" #'centaur-tabs-backward
        "t N" #'centaur-tabs-move-current-tab-to-right
        "t P" #'centaur-tabs-move-current-tab-to-left
        "t g n" #'centaur-tabs-forward-group
        "t g p" #'centaur-tabs-backward-group))


;;evil keybinds

(map! :map evil-normal-state-map
      "U" #'evil-redo)

;; which key

(setq which-key-idle-delay 0.3)

;; company completion

(after! company
  (setq company-idle-delay 0.0
        company-minimum-prefix-length 1)

  (map! "C-." #'+company/complete))

(setq-default history-length 1000)
(setq-default prescient-history-length 1000)

;; lsp
(after! lsp-mode
  (setq lsp-modeline-code-actions-enable t
        lsp-headerline-breadcrumb-enable t
        +format-with-lsp nil
        lsp-lens-enable nil))

(after! ccls
  (setq ccls-initialization-options '(:index (:comments 2) :completion (:detailedLabel t))
        ccls-executable "~/.dotfiles/scripts/.scripts/ccls")
  (set-lsp-priority! 'ccls 0)) ; optional as ccls is the default in Doom

(use-package! lsp-tailwindcss)

;; js modes
(add-hook 'rjsx-mode-hook
          '(lambda()
             (setq tab-width 2)))

;; ligatures
;; cause => is broken in js

(let ((ligatures `((?-  . ,(regexp-opt '("-|" "-~" "---" "-<<" "-<" "--" "->" "->>" "-->")))
                   (?/  . ,(regexp-opt '("/**" "/*" "///" "/=" "/==" "/>" "//")))
                   (?*  . ,(regexp-opt '("*>" "***" "*/")))
                   (?<  . ,(regexp-opt '("<-" "<<-" "<=>" "<=" "<|" "<||" "<|||::=" "<|>" "<:" "<>" "<-<"
                                         "<<<" "<==" "<<=" "<=<" "<==>" "<-|" "<<" "<~>" "<=|" "<~~" "<~"
                                         "<$>" "<$" "<+>" "<+" "</>" "</" "<*" "<*>" "<->" "<!--")))
                   (?:  . ,(regexp-opt '(":>" ":<" ":::" "::" ":?" ":?>" ":=")))
                   (?=  . ,(regexp-opt '("=>>" "==>" "=/=" "=!=" "=>" "===" "=:=" "==")))
                   (?!  . ,(regexp-opt '("!==" "!!" "!=")))
                   (?>  . ,(regexp-opt '(">>" ">]" ">:" ">>-" ">>=" ">=>" ">>>" ">-" ">=")))
                   (?&  . ,(regexp-opt '("&&&" "&&")))
                   (?|  . ,(regexp-opt '("|||>" "||>" "|>" "|]" "|}" "|=>" "|->" "|=" "||-" "|-" "||=" "||")))
                   (?.  . ,(regexp-opt '(".." ".?" ".=" ".-" "..<" "...")))
                   (?+  . ,(regexp-opt '("+++" "+>" "++")))
                   (?\[ . ,(regexp-opt '("[||]" "[<" "[|")))
                   (?\{ . ,(regexp-opt '("{|")))
                   (?\? . ,(regexp-opt '("??" "?." "?=" "?:")))
                   (?#  . ,(regexp-opt '("####" "###" "#[" "#{" "#=" "#!" "#:" "#_(" "#_" "#?" "#(" "##")))
                   (?\; . ,(regexp-opt '(";;")))
                   (?_  . ,(regexp-opt '("_|_" "__")))
                   (?\\ . ,(regexp-opt '("\\" "\\/")))
                   (?~  . ,(regexp-opt '("~~" "~~>" "~>" "~=" "~-" "~@")))
                   (?$  . ,(regexp-opt '("$>")))
                   (?^  . ,(regexp-opt '("^=")))
                   (?\] . ,(regexp-opt '("]#"))))))
  (dolist (char-regexp ligatures)
    (set-char-table-range composition-function-table (car char-regexp)
                          `([,(cdr char-regexp) 0 font-shape-gstring]))))

;; org stuff

(menu-bar-mode 1)
(tool-bar-mode 0)
(scroll-bar-mode 0)
(add-hook! 'org-mode-hook (org-indent-mode 0))

(menu-bar-mode 0)

(setq org-directory "~/My Drive/Org"
      org-ellipsis " ▼ "
      org-list-demote-modify-bullet '(("+" . "*") ("-" . "+") ("*" . "-") ("1." . "a."))
      inhibit-compacting-font-caches t
      org-element-use-cache nil
      org-log-done 'time
      org-startup-with-inline-images t
      org-hugo-base-dir "~/My Drive/Org/braindump"
      org-table-convert-region-max-lines 20000
      org-auto-align-tags nil
      org-tags-column 0
      org-hide-emphasis-markers t
      org-pretty-entities t
      org-tags-column 0
      org-catch-invisible-edits 'show-and-error
      org-insert-heading-respect-content t
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
         "CANCELLED(c)" ))) ; Task has been cancelled

(after! org-modern
  (setq org-modern-star ["◉" "○" "✸" "✿" "✤" "✜" "◆" "▷"]
        org-modern-table-vertical 1
        org-modern-table-horizontal 0.2
        ))

(add-hook 'org-mode-hook #'org-modern-mode)

(custom-set-faces
 '(org-level-1 ((t (:inherit outline-1 :height 1.5))))
 '(org-level-2 ((t (:inherit outline-2 :height 1.4))))
 '(org-level-3 ((t (:inherit outline-3 :height 1.3))))
 '(org-level-4 ((t (:inherit outline-4 :height 1.2))))
 '(org-level-5 ((t (:inherit outline-5 :height 1.1))))
 '(org-level-6 ((t (:inherit outline-6 :height 1.1))))
 '(org-level-7 ((t (:inherit outline-7 :height 1.1))))
 '(org-level-8 ((t (:inherit outline-8 :height 1.1))))
 )

(use-package! org-roam
  :init
  (setq
   org-roam-directory "~/My Drive/Org/braindump/public"
   org-id-link-to-org-use-id t)
  (map! :leader
        (:prefix ("r" . "roam")
         :desc "Open random node" "a" #'org-roam-node-random
         :desc "Toggle roam buffer" "r" #'org-roam-buffer-toggle
         :desc "Insert node" "i" #'org-roam-node-insert
         :desc "Find node" "f" #'org-roam-node-find
         :desc "Find ref" "F" #'org-roam-ref-find
         :desc "Show graph" "g" #'org-roam-ui-open
         :desc "Capture node" "c" #'org-roam-capture
         :desc "Export notes" "e" #'build/export-all
         (:prefix ("t" . "tag")
          :desc "Add TAG to node" "a" #'org-roam-tag-add
          :desc "Remove TAG from node" "r" #'org-roam-tag-remove))))

(use-package! websocket
  :after org-roam)

(use-package! org-roam-ui
  :after org-roam ;; or :after org
  ;;         normally we'd recommend hooking orui after org-roam, but since org-roam does not have
  ;;         a hookable mode anymore, you're advised to pick something yourself
  ;;         if you don't care about startup time, use
  ;;  :hook (after-init . org-roam-ui-mode)
  :config
  (setq org-roam-ui-sync-theme t
        org-roam-ui-follow t
        org-roam-ui-update-on-save t
        org-roam-ui-open-on-start t))

(use-package! ox-hugo
  :after org)

(after! org
  (setq org-agenda-files '("~/My Drive/Org/agenda.org")))
;; org-default-notes-file (expand-file-name "notes.org" org-directory)


(after! org
  (setq org-startup-with-latex-preview t
        org-preview-latex-default-process 'dvisvgm
        org-format-latex-options (plist-put org-format-latex-options :scale 1.75)))


(add-hook 'org-mode-hook 'org-fragtog-mode)


;; Make movement keys work like they should
(define-key evil-normal-state-map (kbd "<remap> <evil-next-line>") 'evil-next-visual-line)
(define-key evil-normal-state-map (kbd "<remap> <evil-previous-line>") 'evil-previous-visual-line)
(define-key evil-motion-state-map (kbd "<remap> <evil-next-line>") 'evil-next-visual-line)
(define-key evil-motion-state-map (kbd "<remap> <evil-previous-line>") 'evil-previous-visual-line)
                                        ; Make horizontal movement cross lines
(setq-default evil-cross-lines t)

;; (setq org-export-with-toc nil)
;; (setq org-export-with-section-numbers nil)
(setq org-publish-project-alist
      '(("org-notes"
         :base-directory "~/My Drive/Org"
         :base-extension "org"
         :publishing-directory "~/My Drive/Org/html"
         :recursive t
         :exclude "org-html-themes/.*"
         :publishing-function org-html-publish-to-htm
         :headline-levels 4
         :auto-preamble t)
        ))

(setq org-export-headline-levels 5)

;; gifs in org
(defun org-inline-image--get-current-image ()
  "Return the overlay associated with the image under point."
  (car (--select (eq (overlay-get it 'org-image-overlay) t) (overlays-at (point)))))

(defun org-inline-image--get (prop)
  "Return the value of property PROP for image under point."
  (let ((image (org-inline-image--get-current-image)))
    (when image
      (overlay-get image prop))))

(defun org-inline-image-animate ()
  "Animate the image if it's possible."
  (interactive)
  (let ((image-props (org-inline-image--get 'display)))
    (when (image-multi-frame-p image-props)
      (image-animate image-props))))

(defun org-inline-image-animate-auto ()
  (interactive)  (when (eq 'org-mode major-mode)
                   (while-no-input
                     (run-with-idle-timer 0.3 nil 'org-inline-image-animate))))

(setq org-inline-image--get-current-image (byte-compile 'org-inline-image--get-current-image))
(setq org-inline-image-animate  (byte-compile 'org-inline-image-animate))
(add-hook 'post-command-hook 'org-inline-image-animate-auto)


;; info-colors
(use-package! info-colors
  :commands (info-colors-fontify-node))

(add-hook 'Info-selection-hook 'info-colors-fontify-node)

;;undotree
(after! undo-tree
  (setq undo-tree-auto-save-history t)
  (map! :leader "u" #'undo-tree-visualize))

;;treesitter

(use-package! tree-sitter
  :config
  (require 'tree-sitter-langs)
  (global-tree-sitter-mode)
  (add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode))

;; treemacs
(after! treemacs
  (setq treemacs-position 'left
        treemacs-git-mode 'deferred))

;; vterm
(after! vterm
  (set-popup-rule! "*doom:vterm-popup:main" :size 0.4 :select t :quit nil :side 'right)
  )

;; yasnippets
(setq yas-snippet-dirs '("~/.doom.d/snippets"))

;; grammar
(setq langtool-java-bin "/usr/local/opt/openjdk/bin/java")
(setq langtool-bin "/opt/homebrew/opt/languagetool/bin/languagetool")
(setq langtool-mother-tongue "en")

