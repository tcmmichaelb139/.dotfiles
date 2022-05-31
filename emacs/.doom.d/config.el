(setq user-full-name "Michael Bao"
      doom-theme 'doom-one
      doom-font (font-spec :family "FiraCode Nerd Font" :size 14)
      ;; setq doom-font (font-spec :family "SauceCodePro Nerd Font" :size 15)
      display-line-numbers-type 'relative

      org-directory "~/My Drive/Org"
      org-ellipsis " ▼ "
      org-superstar-headline-bullets-list '("◉" "●" "○" "◆" "●" "○" "◆")
      org-superstar-item-bullet-alist '((?+ . ?➤) (?- . ?✦)) ; changes +/- symbols in item lists
      inhibit-compacting-font-caches t
      org-element-use-cache nil
      org-log-done 'time
      org-startup-with-inline-images t
      org-hugo-base-dir "~/My Drive/Org/braindump"
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
          "CANCELLED(c)" )) ; Task has been cancelled
      projectile-mode 1
      dtrt-indent-mode 1
      recentf-mode 1
      yas-snippet-dirs '("~/.doom.d/snippets")
      )

(custom-set-faces
  '(org-level-1 ((t (:inherit outline-1 :height 1.5))))
  '(org-level-2 ((t (:inherit outline-2 :height 1.4))))
  '(org-level-3 ((t (:inherit outline-3 :height 1.3))))
  '(org-level-4 ((t (:inherit outline-4 :height 1.2))))
  '(org-level-5 ((t (:inherit outline-5 :height 1.1))))
  )

(setq-default tab-width 4)


(appendq! +ligatures-extra-symbols
          '(
            :checkbox                "☐"
            :pending                 "◼"
            :checkedbox              "☑"
            :begin_quote             "❝"
            :end_quote               "❞"))

(set-ligatures! 'org-mode
                :merge t
                :checkbox                "[ ]"
                :pending                 "[-]"
                :checkedbox              "[X]"
                :begin_quote             "#+begin_quote"
                :end_quote               "#+end_quote")

(plist-put! +ligatures-extra-symbols
            ;; org
            :name          nil
            :src_block     "»"
            :src_block_end "«"
            :quote         nil
            :quote_end     nil
            ;; Functional
            :lambda        nil
            :def           nil
            :composition   nil
            :map           nil
            ;; Types
            :null          nil
            :true          nil
            :false         nil
            :int           nil
            :float         nil
            :str           nil
            :bool          nil
            :list          nil
            ;; Flow
            :not           nil
            :in            nil
            :not-in        nil
            :and           nil
            :or            nil
            :for           nil
            :some          nil
            :return        nil
            :yield         nil
            ;; Other
            :union         nil
            :intersect     nil
            :diff          nil
            :tuple         nil
            :pipe          nil
            :dot           nil)


(use-package! org-roam
              :init
              (setq
                org-roam-directory "~/My Drive/Org/braindump/org"
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

(use-package! tree-sitter
              :hook
              (global-tree-sitter-mode))

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



;; neotree
(after! neotree
        (setq neo-smart-open t
              neo-window-fixed-size nil))
(after! doom-themes
        (setq doom-neotree-enable-variable-pitch t))
(map! :leader
      :desc "Toggle neotree file viewer" "t n" #'neotree-toggle
      :desc "Open directory in neotree" "d n" #'neotree-dir)


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
  (interactive)
  (when (eq 'org-mode major-mode)
    (while-no-input
      (run-with-idle-timer 0.3 nil 'org-inline-image-animate))))


(setq org-inline-image--get-current-image (byte-compile 'org-inline-image--get-current-image))
(setq org-inline-image-animate  (byte-compile 'org-inline-image-animate))
(add-hook 'post-command-hook 'org-inline-image-animate-auto)

(after! undo-tree
        (setq undo-tree-auto-save-history t))

