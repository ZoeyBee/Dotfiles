;;; Package --- Summary
;;; Commentary:
  (require 'package)
  (add-to-list 'package-archives '("melpa" . "https://stable.melpa.org/packages/"))
  (package-initialize)
;;; Code:
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(Tool-bar-mode nil)
 '(cua-mode t nil (cua-base))
 '(custom-safe-themes
   '("3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" "f0bc2876cbcf7cd1536d196ef270b4c4d4712232d6219d08dbf48c2bba524c9a" "bd81bac3569ee67f8b4397432dfcbadc09396996d13ca483d0d8440c7bf87170" "18e60b3301bb6c95a7af129ad7dac1ec0b318403c154c4ce10cf5e789a7f0670" "3eb93cd9a0da0f3e86b5d932ac0e3b5f0f50de7a0b805d4eb1f67782e9eb67a4" "962dacd99e5a99801ca7257f25be7be0cebc333ad07be97efd6ff59755e6148f" default))
 '(menu-bar-mode nil)
 '(org-agenda-files '("~/org" "~/org/work"))
 '(org-export-backends '(ascii beamer html icalendar latex odt))
 '(package-selected-packages
   '(org-edit-latex ## ggtags company-irony-c-headers meson-mode company-ctags company-c-headers xclip vue-mode slack atom-one-dark-theme ack multiple-cursors htmlize org-preview-html json-mode adoc-mode s jedi gdscript-mode doom-themes realgud web-mode Omnisharp shackle ivy sass-mode highlight-parentheses ranger nim-mode kivy-mode company-tern tern nov jedi-direx direx company-jedi evil-goggles helm-make flycheck-irony company-irony irony company auto-complete-clang golden-ratio csharp-mode evil-nerd-commenter yasnippet org-bullets org-beautify-theme helm-gtags markdown-mode helm-projectile evil-magit magit diminish smooth-scrolling smooth-scroll relative-line-numbers all-the-icons dirtree flycheck popup-complete autopair airline-themes linum-relative evil-leader evil-surround projectile evil))
 '(scroll-bar-mode nil)
 '(tooltip-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; (setq org-agenda-files '("~/org" ""))

;; evil-mode
(require 'evil-surround)
(global-evil-surround-mode 1)

(require 'evil-leader)
(global-evil-leader-mode)

(require 'evil)
(evil-mode 1)

;; keybinds
(evil-leader/set-leader ",")
(evil-leader/set-key "f" 'package-install)
(evil-leader/set-key "F" 'package-refresh-contents)
(evil-leader/set-key "RET" 'eshell)
(evil-leader/set-key "d" 'sr-open-file)
(evil-leader/set-key "e" 'helm-for-files)
(evil-leader/set-key "c" 'helm-imenu)
(evil-leader/set-key "s" 'save-buffer)
(evil-leader/set-key "q" 'kill-all-buffers) ;; exit to home directory
(evil-leader/set-key "n" 'xah-new-empty-buffer)
(evil-leader/set-key "k" 'kill-this-buffer)
(evil-leader/set-key "a" 'org-agenda)
(evil-leader/set-key "y" 'yas-new-snippet)
(evil-leader/set-key "u" 'yas-reload-all)
(evil-leader/set-key "m" 'magit-status)
(evil-leader/set-key "," 'delete-window)
(evil-leader/set-key "x" 'with-editor-finish)
(evil-leader/set-key "TAB" 'indent-region)
(evil-leader/set-key ";" 'evilnc-comment-or-uncomment-lines)
(evil-leader/set-key "l" 'flycheck-next-error)
(evil-leader/set-key "L" 'flycheck-previous-error)
(evil-leader/set-key "r" 'replace-string)
(evil-leader/set-key "R" 'revert-buffer-no-confirm)
(evil-leader/set-key "D" 'ranger)
(evil-leader/set-key "g" 'helm-projectile-ack)
(evil-leader/set-key "p" (kbd "C-x 3"))
(evil-leader/set-key "P" (kbd "C-x 2"))
(evil-leader/set-key "t" 'helm-top)
(evil-leader/set-key "v" 'evil-visual-block)
(define-key evil-normal-state-map "\M-l" 'windmove-right)
(define-key evil-normal-state-map "\M-h" 'windmove-left)
(define-key evil-normal-state-map "\M-j" 'windmove-down)
(define-key evil-normal-state-map "\M-k" 'windmove-up)
(define-key evil-visual-state-map "\"" (kbd "S\""))
(define-key evil-visual-state-map "(" (kbd "S)"))
(define-key evil-visual-state-map "[" (kbd "S]"))
(define-key evil-visual-state-map "{" (kbd "S}"))
(define-key evil-visual-state-map "'" (kbd "S'"))
(define-key evil-visual-state-map "\"" (kbd "S\""))

(evil-global-set-key 'normal (kbd "- r") 'projectile-replace)
(evil-global-set-key 'normal (kbd "- z") 'zone)

(defun my/python-mode-hook ()
  "Binds."
  (evil-local-set-key 'normal (kbd "- d") 'jedi:goto-definition))
(add-hook 'python-mode-hook 'my/python-mode-hook)

(defun my/irony-mode-hook ()
  "Binds."
  (evil-local-set-key 'normal (kbd "- c") 'eshell-queue-input("make")))
(add-hook 'irony-mode-hook 'my/irony-mode-hook)

(defun my/org-mode-hook ()
  "Binds."
  (evil-local-set-key 'normal (kbd "- c") 'org-toggle-checkbox)
  (evil-local-set-key 'normal (kbd "- m") 'org-latex-preview)
  (evil-local-set-key 'normal (kbd "- e") 'org-edit-src-code)
  (add-hook 'post-command-hook 'cw/org-auto-toggle-fragment-display t))
(add-hook 'org-mode-hook 'my/org-mode-hook)

(defun my/tern-mode-hook ()
  "Binds."
  (evil-local-set-key 'normal (kbd "- d") 'tern-find-definition)
  (evil-local-set-key 'normal (kbd "- a") 'tern-rename-variable))
(add-hook 'tern-mode-hook 'my/tern-mode-hook)

;; font
(add-to-list 'default-frame-alist '( font . "roboto mono medium 13" ))

;; colour scheme

(require 'atom-one-dark-theme)
(load-theme 'atom-one-dark t)
(setq ns-auto-hide-menu-bar t)
(set-frame-position nil 0 -24)
(tool-bar-mode 0)
(set-frame-size nil 150 80)

(set-face-background 'region "#000000")
(set-face-background 'default "undefined")
(add-to-list 'default-frame-alist '(background-color . "#ffffff00"))

;; line numbers
;; (require 'linum-relative)

;; (defun linum-relative-right-set-margin ()
;;   "Make width of right margin the same as left margin."
;;   (let* ((win (get-buffer-window))
;;      (width (car (window-margins win))))
;;     (set-window-margins win width width)))

;; (defadvice linum-update-current (after linum-left-right-update activate)
;;   "Advice to run right margin update."
;;   (linum-relative-right-set-margin)
;;   (linum-relative-right-update (line-number-at-pos)))

;; (defadvice linum-delete-overlays (after linum-relative-right-delete activate)
;;   "Set margins width to 0."
;;   (set-window-margins (get-buffer-window) 0 0))

;; (defun linum-relative-right-update (line)
;;   "Put relative numbers to the right margin."
;;   (dolist (ov (overlays-in (window-start) (window-end)))
;;     (let ((str (overlay-get ov 'linum-str)))
;;       (if str
;;       (let ((nstr (number-to-string
;;                (abs (- (string-to-number str) line)))))
;;         ;; copy string properties
;;         (set-text-properties 0 (length nstr) (text-properties-at 0 str) nstr)
;;         (overlay-put ov 'after-string
;;              (propertize " " 'display `((margin right-margin) ,nstr))))))))

;; (linum-relative-global-mode 1)


;; helm
(require 'helm-config)

;; projectile
(require 'projectile)
(require 'helm-projectile)

(defun sr-open-file ()
  "Open files."
  (interactive)
  (if (projectile-project-p)
      (helm-projectile)
  (helm-for-files)))


;; powerline
;; (require 'powerline)
;; (powerline-default-theme)
(require 'airline-themes)
(load-theme 'airline-onedark t)
(setq-default mode-line-format nil)

;; auto close brackets
(electric-pair-mode 1)

;; silent bell
(setq ring-bell-function 'ignore)

;; async
(autoload 'dired-async-mode "dired-async.el" nil t)
(dired-async-mode 1)

(require 'jedi)
(defun python-jedi-hook-f()
  (let ((local-virtual-env (locate-dominating-file default-directory "virtualenv")))
    (if (and local-virtual-env (file-exists-p local-virtual-env))
         (progn
           (setq jedi:environment-root (concat local-virtual-env "virtualenv"))
        ))

  ;; (run-python "/usr/bin/python3 -i")

  (jedi:setup)
    (setq jedi:environment-virtualenv
        (append python-environment-virtualenv
                '("--python" "/usr/bin/python3")))
))

;; (add-hook 'python-mode-hook 'python-jedi-hook-f)
(jedi:setup)

(with-eval-after-load 'company
  (add-to-list 'company-backends 'company-jedi)
  (add-to-list 'company-backends 'company-c-headers)
  (add-to-list 'company-backends 'company-ctags))

;; linting
(require 'flycheck)
(global-flycheck-mode)

;; turn on flychecking globally
(add-hook 'after-init-hook #'global-flycheck-mode)

;; use eslint with rsjx-mode for jsx files
;; (flycheck-add-mode 'javascript-eslint 'rjsx-mode)

;; customize flycheck temp file prefix
(setq-default flycheck-temp-prefix ".flycheck")

;; disable json-jsonlist checking for json files
;; (setq-default flycheck-disabled-checkers
;;   (append flycheck-disabled-checkers
;;     '(json-jsonlist)))


;; scrolling
(require 'smooth-scrolling)
(setq scroll-margin 5)
scroll-conservatively 9999

;; disable backup files
(setq make-backup-files nil)

(setq vc-follow-symlinks t)

(defun kill-other-buffers ()
    "Kill all other buffers."
    (interactive)
    (mapc 'kill-buffer (delq (current-buffer) (buffer-list))))

(defun kill-all-buffers ()
    "Kill all other buffers."
    (interactive)
    (mapc 'kill-buffer (delq (current-buffer) (buffer-list)))
    (kill-buffer)
    (setq default-directory "~/")
    (kill-other-buffers))


(windmove-default-keybindings)

(setq-default indent-tabs-mode nil)
(setq-default c-basic-offset 4 c-default-style "linux")
(setq-default tab-width 4)
(setq indent-line-function 'insert-tab)

(defun xah-new-empty-buffer ()
  "Create a new empty buffer.
new buffer will be named “untitled” or “untitled<2>”, “untitled<3>”, etc."
  (interactive)
  (let ((-buf (generate-new-buffer "untitled")))
    (switch-to-buffer -buf)
    (funcall initial-major-mode)
    (setq default-directory "~/")
    (setq buffer-offer-save t)))


(require 'markdown-mode)

(require 'org-bullets)

(add-hook 'org-mode-hook
          (lambda()
            (org-bullets-mode t )))

(setq org-hide-leading-stars t)

(add-hook 'org-mode-hook
      '(lambda ()
         (delete '("\\.pdf\\'" . default) org-file-apps)
         (add-to-list 'org-file-apps '("\\.pdf\\'" . "mupdf %s"))
         (delete '("\\.html\\'" . default) org-file-apps)
         (add-to-list 'org-file-apps '("\\.html\\'" . "qutebrowser %s"))))

(require 'yasnippet)
(yas-global-mode 1)

(setq yas-snippet-dirs '("~/Dotfiles/emacs/yasnippets/"))

(defun my/capitalize-first-char (&optional string)
  "Capitalize only the first character of the input STRING."
  (when (and string (> (length string) 0))
    (let ((first-char (substring string nil 1))
          (rest-str   (substring string 1)))
      (concat (capitalize first-char) rest-str))))

(require 'magit)
(require 'evil-magit)

(defun minibuffer-keyboard-quit ()
  "Abort recursive edit.
In Delete Selection mode, if the mark is active, just deactivate it;
then it takes a second \\[keyboard-quit] to abort the minibuffer."
  (interactive)
  (if (and delete-selection-mode transient-mark-mode mark-active)
      (setq deactivate-mark  t)
    (when (get-buffer "*Completions*") (delete-windows-on "*Completions*"))
    (abort-recursive-edit)))

(define-key evil-normal-state-map [escape] 'keyboard-quit)
(define-key evil-visual-state-map [escape] 'keyboard-quit)
(define-key minibuffer-local-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-ns-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-completion-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-must-match-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-isearch-map [escape] 'minibuffer-keyboard-quit)


(evilnc-default-hotkeys t)

(add-hook 'latex-mode-hook 'preview-buffer)


(require 'company)
(add-hook 'after-init-hook 'global-company-mode)
(setq company-idle-delay 0.2)

(require 'irony)
(require 'company-irony)
(add-to-list 'company-backends '(company-irony-c-headers company-irony))
(add-hook 'flycheck-mode-hook #'flycheck-irony-setup)

(add-hook 'c++-mode-hook 'irony-mode)
(add-hook 'c-mode-hook 'irony-mode)
(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)

(require 'evil-goggles)
(evil-goggles-mode)
(setq evil-goggles-duration 0.050)
;; list of all on/off variables, their default value is `t`:
;;
;; evil-goggles-enable-delete
;; evil-goggles-enable-indent
;; evil-goggles-enable-yank
;; evil-goggles-enable-join
;; evil-goggles-enable-fill-and-move
;; evil-goggles-enable-paste
;; evil-goggles-enable-shift
;; evil-goggles-enable-surround
;; evil-goggles-enable-commentary
;; evil-goggles-enable-replace-with-register
;; evil-goggles-enable-set-marker


(add-to-list 'auto-mode-alist '("*[\\S]rc" . conf-unix-mode))

(require 'gdscript-mode)

(defun revert-buffer-no-confirm ()
    "Revert buffer without confirmation."
    (interactive)
    (revert-buffer :ignore-auto :noconfirm))



(require 'tern)

(add-hook 'js-mode-hook (lambda () (tern-mode t)))
(setq js-indent-level 2)

(add-hook 'html-mode-hook
 (lambda ()
   (setq-local electric-pair-inhibit-predicate
               `(lambda (c)
                  (if (char-equal c ?<) t (,electric-pair-inhibit-predicate c))))))

(add-hook 'gdscript-mode-hook (lambda () (evil-leader/set-key "z" 'gdscript-indent-line)))

(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.html$" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml$" . web-mode))
(add-to-list 'auto-mode-alist '("\\.ts$" . web-mode))
(add-to-list 'auto-mode-alist '("\\.js$" . web-mode))
(add-to-list 'auto-mode-alist '("\\.dtl$" . web-mode))
(add-to-list 'auto-mode-alist '("\\.cshtml$" . web-mode))
(setq web-mode-enable-current-element-highlight t)
(eval-after-load "web-mode"
  '(set-face-background 'web-mode-current-element-highlight-face "#00272b33"))

(add-to-list 'auto-mode-alist '("\\.qss$" . css-mode))

(require 'kivy-mode)
(add-to-list 'auto-mode-alist '("\\.kv$" . kivy-mode))

(require 'nim-mode)

(require 'ranger)
(setq ranger-show-hidden t)
(setq ranger-cleanup-on-disable t)
(setq ranger-cleanup-eagerly t)
(setq ranger-modify-header nil)
(setq ranger-preview-file nil)
(setq ranger-footer-delay 0.01)

(setq helm-projectile-window-style 'same-window)
(setq helm-window-style 'same-window)

(setq inhibit-startup-screen t)
(setq initial-scratch-message nil)
(setq initial-major-mode 'org-mode)

(show-paren-mode 1)
(setq show-paren-delay 0)
(require 'paren)
(set-face-background 'show-paren-match (face-background 'default))
(set-face-foreground 'show-paren-match "#f3f4f5")

(golden-ratio-mode 1)

;; C# stuff, keep disabled
;; (require 'popwin)
;; (push '("^\*helm.+\*$" :regexp t) popwin:special-display-config)
;; (push '(t :dedicated t) popwin:special-display-config)
;; (setq popwin:popup-window-height 1)
;; (add-hook 'helm-after-initialize-hook (lambda ()
;;                                           (popwin:display-buffer helm-buffer t)
;;                                           (popwin-mode -1)))

;; (add-hook 'helm-cleanup-hook (lambda () (popwin-mode 1)))
;; (add-hook 'ranger-mode-hook (lambda () (popwin-mode -1)))
;; (add-hook 'magit-mode-hook (lambda () (popwin-mode -1)))

;; (require 'omnisharp)
;; (omnisharp-start-omnisharp-server "/home/martin/.emacs.d/.cache/omnisharp/server/v1.26.3/run")

;; (eval-after-load
;;   'company
;;   '(add-to-list 'company-backends 'company-omnisharp))

;; (defun my-csharp-mode-setup ()
;;   (omnisharp-mode)

;;   (setq indent-tabs-mode nil)
;;   (setq c-syntactic-indentation t)
;;   (c-set-style "ellemtel")
;;   (setq c-basic-offset 4)
;;   (setq truncate-lines t)
;;   (setq tab-width 4)
;;   (setq evil-shift-width 4)

;;   ;csharp-mode README.md recommends this too
;;   ;(electric-pair-mode 1)       ;; Emacs 24
;;   ;(electric-pair-local-mode 1) ;; Emacs 25

;;   (local-set-key (kbd "C-c r r") 'omnisharp-run-code-action-refactoring)
;;   (local-set-key (kbd "C-c C-c") 'recompile))

;; (add-hook 'csharp-mode-hook 'my-csharp-mode-setup t)

(global-whitespace-mode t)
(setq whitespace-style (quote (face trailing space-before-tab)))

(require 'realgud)

;disable auto save
(setq backup-inhibited t)
(setq auto-save-default nil)

(require 's)

(require 'adoc-mode)
(setq tern-command (append tern-command '("--no-port-file")))

(require 'htmlize)

(defvar cw/org-last-fragment nil
  "Holds the type and position of last valid fragment we were on. Format: (FRAGMENT_TYPE FRAGMENT_POINT_BEGIN)"
  )

(setq cw/org-valid-fragment-type
      '(latex-fragment
        latex-environment
        link))

(defun cw/org-curr-fragment ()
  "Returns the type and position of the current fragment available for preview inside org-mode. Returns nil at non-displayable fragments"
  (let* ((fr (org-element-context))
         (fr-type (car fr)))
    (when (memq fr-type cw/org-valid-fragment-type)
      (list fr-type
            (org-element-property :begin fr))))
  )

(defun cw/org-remove-fragment-overlay (fr)
  "Remove fragment overlay at fr"
  (let ((fr-type (nth 0 fr))
        (fr-begin (nth 1 fr)))
    (goto-char fr-begin)
    (cond ((or (eq 'latex-fragment fr-type)
               (eq 'latex-environment fr-type))
           (let ((ov (loop for ov in (org--list-latex-overlays)
                           if
                           (and
                            (<= (overlay-start ov) (point))
                            (>= (overlay-end ov) (point)))
                           return ov)))
             (when ov
               (delete-overlay ov))))
          ((eq 'link fr-type)
           nil;; delete image overlay here?
           ))
    ))

(defun cw/org-preview-fragment (fr)
  "Preview org fragment at fr"
  (let ((fr-type (nth 0 fr))
        (fr-begin (nth 1 fr)))
    (goto-char fr-begin)

    ;; Setup rendering for tikzpicture when needed
    ;; requires you to have \begin{tikzpicture} on the same line as the initial $$
    (if (cl-search "tikzpicture" (thing-at-point 'line t))
        (progn
          (setq org-preview-latex-default-process 'imagemagick)
          (setq org-format-latex-options (plist-put org-format-latex-options :scale 1))
          (unless (member '("" "tikz" t) org-latex-packages-alist) (add-to-list 'org-latex-packages-alist '("" "tikz" t)))
          (unless (member '("" "pgfplots" t) org-latex-packages-alist) (add-to-list 'org-latex-packages-alist '("" "pgfplots" t))))
      (progn
        (setq org-preview-latex-default-process 'dvipng)
        (setq org-format-latex-options (plist-put org-format-latex-options :scale 2))
        (when (member '("" "pgfplots" t) org-latex-packages-alist) (pop org-latex-packages-alist))
        (when (member '("" "tikz" t) org-latex-packages-alist) (pop org-latex-packages-alist))))

    (cond ((or (eq 'latex-fragment fr-type) ;; latex stuffs
               (eq 'latex-environment fr-type))
           (when (cw/org-curr-fragment) (org-preview-latex-fragment))) ;; only toggle preview when we're in a valid region (for inserting in the front of a fragment)


          ((eq 'link fr-type) ;; for images
           (let ((fr-end (org-element-property :end (org-element-context))))
             (org-display-inline-images nil t fr-begin fr-end))))
    ))


(defun cw/org-auto-toggle-fragment-display ()
  "Automatically toggle a displayable org mode fragment"
  (and (eq 'org-mode major-mode)
       (let ((curr (cw/org-curr-fragment)))
         (cond
          ;; were on a fragment and now on a new fragment
          ((and
            ;; fragment we were on
            cw/org-last-fragment
            ;; and are on a fragment now
            curr
            ;; but not on the last one this is a little tricky. as you edit the
            ;; fragment, it is not equal to the last one. We use the begin
            ;; property which is less likely to change for the comparison.
            (not (equal curr cw/org-last-fragment)))

           ;; go back to last one and put image back, provided there is still a fragment there
           (save-excursion
             (cw/org-preview-fragment cw/org-last-fragment)
             ;; now remove current image
             (cw/org-remove-fragment-overlay curr)
             ;; and save new fragment
             )
           (setq cw/org-last-fragment curr))

          ;; were on a fragment and now are not on a fragment
          ((and
            ;; not on a fragment now
            (not curr)
            ;; but we were on one
            cw/org-last-fragment)
           ;; put image back on, provided that there is still a fragment here.
           (save-excursion
             (cw/org-preview-fragment cw/org-last-fragment))

           ;; unset last fragment
           (setq cw/org-last-fragment nil))

          ;; were not on a fragment, and now are
          ((and
            ;; we were not one one
            (not cw/org-last-fragment)
            ;; but now we are
            curr)
           ;; remove image
           (save-excursion
             (cw/org-remove-fragment-overlay curr)
             )
           (setq cw/org-last-fragment curr))

          ))))

(add-to-list 'org-latex-packages-alist '("" "polynom" t))
(add-to-list 'org-latex-packages-alist '("" "cancel" t))
(setq org-preview-latex-default-process 'dvipng)
(setq org-format-latex-options (plist-put org-format-latex-options :scale 2))

(yas-reload-all)

(setq mmm-submode-decoration-level 0)

;; (set-face-background 'region "#a4a4a4")
;; (set-face-background 'region "#000000")
;;(set-face-background 'default "undefined")
(set-face-background 'helm-ff-file "undefined")
(add-to-list 'default-frame-alist '(background-color . "#ffffff00"))

(require 'xclip)
(xclip-mode 1)

(setq-default c-basic-offset 2)
(setq yas-indent-line (quote none))

(setq org-startup-with-inline-images 't)

(add-to-list 'auto-mode-alist '("\\.ino$" . c++-mode))

(provide '.emacs)
;;; .emacs ends here
