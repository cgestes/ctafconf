;;
;; functions.emacs for ctafconf in /home/ctaf/
;;
;; Made by GESTES Cedric
;; Login   <ctaf42@gmail.com>
;;
;; Started on  Mon Jan 16 00:58:57 2006 GESTES Cedric
;; Last update Thu May 27 18:21:10 2010 Cedric GESTES
;;
(message ".")
(message "ctafconf loading: FUNCTIONS.EMACS")


;;;;FONCTIONS
;;list-colors-display to display all color
; Conversion des fins de lignes du format MS-DOS au format Unix
(defun dos2unix ()
  (interactive)
  (goto-char (point-min))
  (while (search-forward "\r" nil t)
    (replace-match "")
  )
)


; Conversion des fins de ligne du format Unix au format MS-DOS
(defun unix2dos ()
  (interactive)
  (goto-char (point-min))
  (while (search-forward "\n" nil t)
    (replace-match "\r\n")
  )
)

;;test si on est en graphique
;; from command line: emacs -g 80x40
(defun ctafconf-resize-80x25()
  "resize the terminal"
  (if window-system
      (progn
        (interactive)
        (set-frame-width (selected-frame) 80)
        (set-frame-height (selected-frame) 27)
        )
    )
  )

