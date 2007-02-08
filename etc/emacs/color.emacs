;;
;; color.emacs for GRK in /home/ctaf/.ctafconf/etc/emacs
;;
;; Made by GESTES Cedric
;; Login   <ctaf@epita.fr>
;;
;; Started on  Thu May 11 19:53:25 2006 GESTES Cedric
;; Last update Tue Feb  6 17:15:23 2007 GESTES Cedric
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
   '(default														 ((t (:background "black"		:foreground "white" ))))
   '(cursor														 ((t (:background "white"		:foreground "black" ))))
   '(highlight													 ((t (:background "yellow"  :foreground "black"))))
   '(region														 ((t (:background "blue"		:foreground "white"))))
   '(isearch														 ((t (:background "blue"    :foreground "white"))))
   '(trailing-whitespace								 ((t (:background "blue"))))
   '(font-lock-comment-face             ((t (:foreground "red"))))
   '(font-lock-function-name-face       ((t (:foreground "orange"))))
   '(font-lock-builtin-face             ((t (:foreground "magenta"))))
   '(font-lock-string-face              ((t (:foreground "green"))))
   '(font-lock-constant-face            ((t (:foreground "cyan"))))
   '(font-lock-keyword-face             ((t (:foreground "yellow"))))
   '(font-lock-type-face                ((t (:foreground "green"))))
   '(font-lock-variable-name-face       ((t (:foreground "blue"))))
   '(font-lock-warning-face						 ((t (:foreground "red"))))))


(defun x-color-theme()
  "A color scheme"
  (interactive "")
  ;;WINDOW
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


;;;;;;STYLE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;color
(set-face-background   'modeline "black")
(set-face-foreground   'modeline "steelblue3")
(set-face-background   'scroll-bar "#0050C5")
(set-face-foreground   'scroll-bar "#0050C5")

;;test si on est en graphique
;;(if window-system
;;    (setq default-frame-alist
;;      '((width . 80) (height . 30)
;;        (cursor-color . "yellow")
;;        (cursor-type . box)
;;        (foreground-color . "MediumPurple2")
;;        (background-color . "black")))
;;)


(if running-on-x
    (x-color-theme)
  (console-color-theme))

