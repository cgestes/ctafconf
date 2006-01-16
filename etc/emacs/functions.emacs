;;
;; functions.emacs for ctafconf in /home/ctaf/
;;
;; Made by GESTES Cedric
;; Login   <ctaf@epita.fr>
;;
;; Started on  Mon Jan 16 00:58:57 2006 GESTES Cedric
;; Last update Mon Jan 16 02:09:10 2006 GESTES Cedric
;;
(message "ctafconf loading: FUNCTIONS.EMACS")

(defun devenv()
  (interactive)
  (split-window-vertically 55)
  (find-file "ChangeLog")
  (split-window-horizontally)
  (other-window 2)
  (split-window-horizontally)
  (other-window 1)
  (ansi-term "/bin/sh")
  (other-window 1)
  (find-file "main.cc")
  ;;on active l'auto-scrolling ohorizontal:
  (hscroll-global-mode)
  ;;on lance la speedar
  (speedbar)
  )

(defun jl-kill-region ()
  "if the mark is not active kill the current word \
  or if the mark is active kill the active region"
  (interactive)
  (if (equal mark-active t)
    (kill-region (region-beginning) (region-end))
    (progn
      (search-backward " ")
      (kill-word 1)
      (insert " "))
    )
  )


;;; some functions
(defun push-line ()
  "Select current line, push onto kill ring."
  (interactive)
  (save-excursion
    (copy-region-as-kill (re-search-backward "^") (re-search-forward "$"))))
(global-set-key "\C-cp" 'push-line)

(defun push-rest-of-line ()
  "Select text from point to end of current line, push onto kill ring."
  (interactive)
  (save-excursion
    (copy-region-as-kill (point) (re-search-forward "$"))))

(global-set-key "\C-ck" 'push-rest-of-line)
(global-set-key "\C-w"  'jl-kill-region)


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

;; Zlock handling for emacs
(defun zlock ()
  (interactive)
  (shell-command "zlock -immed"))
