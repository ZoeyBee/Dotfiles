
;;; Code:

(deftheme airline-dark
  "source: https://github.com/bling/vim-airline/blob/master/autoload/airline/themes/dark.vim")

(let ((normal-outer-foreground  "#303739") (normal-outer-background  "#98c379")
      (normal-inner-foreground  "#9399a6") (normal-inner-background  "#3e4452")
      (normal-center-foreground "#9399a6") (normal-center-background "#272b33")

      (insert-outer-foreground  "#303739") (insert-outer-background  "#61afef")
      (insert-inner-foreground  "#9399a6") (insert-inner-background  "#3e4452")
      (insert-center-foreground "#9399a6") (insert-center-background "#272b33")

      (visual-outer-foreground  "#303739") (visual-outer-background  "#c678dd")
      (visual-inner-foreground  "#9399a6") (visual-inner-background  "#3e4452")
      (visual-center-foreground "#9399a6") (visual-center-background "#272b33")

      (replace-outer-foreground  "#303739") (replace-outer-background  "#303739")
      (replace-inner-foreground  "#9399a6") (replace-inner-background  "#3e4452")
      (replace-center-foreground "#9399a6") (replace-center-background "#272b33")

      (emacs-outer-foreground  "#d7d7ff") (emacs-outer-background  "#5f00af")
      (emacs-inner-foreground  "#9399a6") (emacs-inner-background  "#3e4452")
      (emacs-center-foreground "#9399a6") (emacs-center-background "#272b33")

      (inactive1-foreground "#303739") (inactive1-background "#98c379")
      (inactive2-foreground "#9399a6") (inactive2-background "#3e4452")
      (inactive3-foreground "#9399a6") (inactive3-background "#272b33"))

  (airline-themes-set-deftheme 'airline-dark)

  (when airline-cursor-colors
    (progn
     (setq evil-emacs-state-cursor   emacs-outer-background)
     (setq evil-normal-state-cursor  normal-outer-background)
     (setq evil-insert-state-cursor  `(bar ,insert-outer-background))
     (setq evil-replace-state-cursor replace-outer-background)
     (setq evil-visual-state-cursor  visual-outer-background)))
)

(airline-themes-set-modeline)

(provide-theme 'airline-dark)
;;; airline-dark-theme.el ends here
