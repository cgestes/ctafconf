;;
;; color.emacs for GRK in /home/ctaf/.ctafconf/etc/emacs
;;
;; Made by GESTES Cedric
;; Login   <ctaf42@gmail.com>
;;
;; Started on  Thu May 11 19:53:25 2006 GESTES Cedric
;; Last update Sat Jun 28 12:04:02 2008 GESTES Cedric
;;
;; source: http://blog.pettomato.com/content/site-lisp/.emacs
(message ".")
(message "ctafconf loading: COLOR.EMACS")

(defvar running-on-windows (memq system-type '(windows-nt cygwin)))
(defvar running-on-linux (not running-on-windows))
(defvar running-on-x (eq window-system 'x))


(defun console-color-theme()
  "A console scheme"
  (interactive "")
  (set-face-background   'modeline "black")
  (set-face-foreground   'modeline "steelblue3")


  ;;WINDOWS
  (setq default-frame-alist
        '((foreground-color . "white")
          (background-color . "black")
					(background-mode  . dark)))

  ;;CURSOR
  (set-cursor-color "green")
  (set-mouse-color "white")


  ;;SYNTAX COLORATION
  (custom-set-faces
   '(default		                ((t (:background "black"		:foreground "white" ))))
   '(cursor                             ((t (:background "white"		:foreground "black" ))))
   '(highlight                          ((t (:background "yellow"  :foreground "black"))))
   '(region                             ((t (:background "blue"		:foreground "white"))))
   '(isearch                            ((t (:background "blue"    :foreground "white"))))
   '(trailing-whitespace		((t (:background "blue"))))
   '(font-lock-comment-face             ((t (:foreground "red"))))
   '(font-lock-function-name-face       ((t (:foreground "orange"))))
   '(font-lock-builtin-face             ((t (:foreground "magenta"))))
   '(font-lock-string-face              ((t (:foreground "green"))))
   '(font-lock-constant-face            ((t (:foreground "cyan"))))
   '(font-lock-keyword-face             ((t (:foreground "yellow"))))
   '(font-lock-type-face                ((t (:foreground "green"))))
   '(font-lock-variable-name-face       ((t (:foreground "blue"))))
   '(font-lock-warning-face		((t (:foreground "red"))))))


(defun x-color-theme()
  "A color scheme"
  (interactive "")
  ;;WINDOW
  (set-face-background   'modeline "black")
  (set-face-foreground   'modeline "steelblue3")


  (setq default-frame-alist
        '((background-mode  . dark)
          (display-type . color)
          (cursor-type . box)
          ;;(scroll-bar-background . "grey75")
          ;;(scroll-bar-foreground)
          (border-color . "black")
          (cursor-color . "#7ac470")
          (mouse-color . "white")
          (background-color . "#000000")
          (foreground-color . "#f0f0f0")
          ))

  ;;define some color
  (let ((black "#000000")
        (red "#a35757")
        (green "#7ac470")
        (yellow "#dfe14e")
        (orange "#ef6d22")
        (blue "#5083b2")
        (magenta "#b781ac")
        (cyan "#b0b5d2")
        (white "#f0f0f0"))
    ;;SYNTAX
    (custom-set-faces
     `(default														((t (:background ,black		:foreground ,white ))))
     `(cursor														  ((t (:background ,green		:foreground ,black ))))
     `(highlight													((t (:background ,yellow   :foreground ,black))))
     `(region														  ((t (:background ,blue			:foreground ,white))))
     `(isearch														((t (:background ,blue			:foreground ,white))))
     `(trailing-whitespace								((t (:background ,blue))))
     `(font-lock-comment-face             ((t (:foreground ,red))))
     `(font-lock-function-name-face       ((t (:foreground ,orange))))
     `(font-lock-builtin-face             ((t (:foreground ,magenta))))
     `(font-lock-string-face              ((t (:foreground ,green))))
     `(font-lock-constant-face            ((t (:foreground ,cyan))))
     `(font-lock-keyword-face             ((t (:foreground ,yellow))))
     `(font-lock-type-face                ((t (:foreground ,green))))
     `(font-lock-variable-name-face       ((t (:foreground ,blue))))
     `(font-lock-warning-face						  ((t (:foreground ,red))))
     `(hi-blue														((t (:foreground ,blue))))
     `(hi-green														((t (:foreground ,green))))
     `(hi-yellow													((t (:foreground ,yellow))))
     `(hi-red-b														((t (:foreground ,red))))
     `(hi-pink														((t (:foreground ,magenta)))))))


(defun happy-coder-color-theme()
  "A color scheme"
  (interactive "")

  (setq default-frame-alist
        '((background-mode  . dark)
          (display-type . color)
          (cursor-type . box)
          ;;(scroll-bar-background . "grey75")
          ;;(scroll-bar-foreground)
          (border-color . "black")
          (cursor-color . "#7ac470")
          (mouse-color . "white")
          (background-color . "#000000")
          (foreground-color . "#f0f0f0")
          ))

  ;; couleur de fond en noir et caracteres en blanc
   (set-background-color "Black")
   (set-foreground-color "White")

  (custom-set-faces
   ;; custom-set-faces was added by Custom -- don't edit or cut/paste it!
   ;; Your init file should contain only one such instance.
   '(background "blue")
   '(trailing-whitespace ((t (:background "cyan"))))
   '(font-lock-builtin-face ((((class color) (background dark)) (:foreground "Turquoise"))))
   '(font-lock-comment-face ((t (:foreground "MediumAquamarine"))))
   '(font-lock-constant-face ((((class color) (background dark)) (:bold t :foreground "DarkOrchid"))))
   '(font-lock-doc-string-face ((t (:foreground "green2"))))
   '(font-lock-function-name-face ((t (:foreground "SkyBlue"))))
   '(font-lock-keyword-face ((t (:bold t :foreground "CornflowerBlue"))))
   '(font-lock-preprocessor-face ((t (:italic nil :foreground "CornFlowerBlue"))))
   '(font-lock-reference-face ((t (:foreground "DodgerBlue2"))))
   '(font-lock-string-face ((t (:foreground "lime green"))))
   '(font-lock-type-face ((t (:foreground "#9290ff"))))
   '(font-lock-variable-name-face ((t (:foreground "PaleGreen"))))
   '(font-lock-warning-face ((((class color) (background dark)) (:foreground "yellow" :background "red"))))
   '(highlight ((t (:background "CornflowerBlue"))))
   '(list-mode-item-selected ((t (:background "gold"))))
   '(makefile-space-face ((t (:background "wheat"))))
;;   '(modeline ((t (:background "Navy"))))
   '(paren-match ((t (:background "darkseagreen4"))))
   '(region ((t (:background "DarkSlateBlue"))))
   '(show-paren-match-face ((t (:foreground "black" :background "wheat"))))
   '(show-paren-mismatch-face ((((class color)) (:foreground "white" :background "red"))))
   '(speedbar-button-face ((((class color) (background dark)) (:foreground "green4"))))
   '(speedbar-directory-face ((((class color) (background dark)) (:foreground "khaki"))))
   '(speedbar-file-face ((((class color) (background dark)) (:foreground "cyan"))))
   '(speedbar-tag-face ((((class color) (background dark)) (:foreground "Springgreen"))))
   '(vhdl-speedbar-architecture-selected-face ((((class color) (background dark)) (:underline t :foreground "Blue"))))
   '(vhdl-speedbar-entity-face ((((class color) (background dark)) (:foreground "darkGreen"))))
   '(vhdl-speedbar-entity-selected-face ((((class color) (background dark)) (:underline t :foreground "darkGreen"))))
   '(vhdl-speedbar-package-face ((((class color) (background dark)) (:foreground "black"))))
   '(vhdl-speedbar-package-selected-face ((((class color) (background dark)) (:underline t :foreground "black"))))
   '(widget-field-face ((((class grayscale color) (background light)) (:background "DarkBlue")))))
  )




;;;;;;STYLE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;color
(happy-coder-color-theme)
;; (if running-on-x
;;     (x-color-theme)
;;   (console-color-theme))

(set-face-background   'modeline "black")
(set-face-foreground   'modeline "steelblue3")
(set-face-background   'scroll-bar "#0050C5")
(set-face-foreground   'scroll-bar "#0050C5")


;; to save your color theme:
;; (require 'color-theme)
;; color-theme-print
;; roxor!
