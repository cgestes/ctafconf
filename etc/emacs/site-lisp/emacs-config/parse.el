;;
;; parse.el
;; 
;; Made by (jean-baptiste julien)
;; Login   <julien_j@umoth>
;; 
;; Started on  Mon Sep 24 11:19:54 2001 jean-baptiste julien
;; Last update Sat Oct 27 22:46:41 2001 jb
;;
;;
(defun start-and-output(cmd)
  (interactive())
  (call-process cmd
		nil "*cmd" nil
		param1)
  (display-buffer "*cmd")
)

(defun call-verif-rep()
  (interactive())
  (if (buffer-file-name)
      (progn
	(setq bufname (buffer-file-name))
	(setq reprendu (read-string "Repertoire : " (file-name-directory bufname)))
	(switch-to-buffer-other-window "*cmd")
	(erase-buffer)
	(insert (current-time-string))
	(insert "\n")
	(call-process "~/tools/perl/parse.pl" nil "*cmd" nil reprendu "nocolor")
	(display-buffer "*cmd")
	(goto-char (point-min))
	(switch-to-buffer-other-window (get-file-buffer bufname))
	)
    )
  )

(defun call-verif()
  (interactive())
  (if (buffer-file-name)
      (progn
	(setq bufname (buffer-file-name))
	(switch-to-buffer-other-window "*cmd")
	(erase-buffer)
	(insert (current-time-string))
	(insert "\n")
	(insert "\n-------Parse perl------\n")
	(call-process "~/tools/perl/parse.pl" nil "*cmd" nil bufname "nocolor")
	(display-buffer "*cmd")
	(goto-char (point-min)) 
	(switch-to-buffer-other-window (get-file-buffer bufname))
	)
      )
)