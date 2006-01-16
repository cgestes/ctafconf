;;
;; reindent.el
;; 
;; Made by (jean-baptiste julien)
;; Login   <julien_j@stan>
;; 
;; Started on  Thu Sep 27 11:26:09 2001 jean-baptiste julien
;; Last update Thu Mar 14 19:23:49 2002 Pepe
;;


(defun file-get-suffix (file)
  "Return the file suffix for FILE, or NIL if none."
  (if (string-match "\\.\\([^./]+\\)$" file)
      (substring file (match-beginning 1) (match-end 1))))

(defun reindent-rep()
  (interactive())
  (if (buffer-file-name)
      (progn
	 (defvar bufname)
	 (defvar reprendu)
	 (defvar files)
	 (setq bufname (buffer-file-name))
	 (setq reprendu (read-string "Repertoire : " (file-name-directory bufname)))
	 (setq files (directory-files reprendu))
	 (while files
	   (progn
	    (if (or (string= (file-get-suffix (car files)) "c")
	    	    (string= (file-get-suffix (car files)) "h")
	    	    (string= (file-get-suffix (car files)) "cc")
	    	    (string= (file-get-suffix (car files)) "hh"))
	    	(reindent (car files))
	    	)
	    (setq files (cdr files))
	    )
	)
	(message (concat reprendu " reindented"))
	(makunbound `bufname)
	(makunbound `reprendu)
	(makunbound `files)
      )
    )
)

(defun reindent (file)
  (interactive)
  (defvar buf)
  (setq buf (get-file-buffer file))
  (if buf
      (save-excursion 
	(set-buffer buf)
	(indent-region (point-min) (point-max) nil)
      )
    )
  (if (not buf)
      (progn
	(defvar thehooks)
	(setq thehooks find-file-hooks)
	(setq find-file-hooks (list))
	(find-file file)
	(c-mode)
	(indent-region (point-min) (point-max) nil)
	(save-buffer)
	(kill-buffer nil)
	(setq find-file-hooks thehooks)
	(makunbound `thehooks)
	)
    )
  (makunbound `buf)
  )

(defun reindent-file ()
  (interactive())
  (if (buffer-file-name)
      (progn
	(reindent (buffer-file-name))
	(message (concat (buffer-file-name) " reindented"))
	)
    )
)


(defun select-all ()
  (interactive)
  (set-mark (point-min))
  (goto-char (point-max))
)
