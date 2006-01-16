(defvar buffer-header)

(defun autoh-header-maj()
  (interactive())
  (if (and buffer-file-name 
	   (string= (file-get-suffix (buffer-name)) "c"))
      (progn
	(setq buffer-header  (concat (file-strip-suffix (buffer-name)) ".h"))
	(if (not (file-exists-p buffer-header))
	    (message "You need to create the .h file first")
	  )
	(if (file-exists-p buffer-header)
	    (progn
	      (setq filename (file-strip-suffix (buffer-name)))
	      (call-process "~/tools/autoh/autoh"
			    nil nil nil
			    "-f"
			    filename)
	      (save-excursion
		(message buffer-header)
		(if (get-buffer buffer-header)
		    (progn
		      (set-buffer buffer-header)
		      (revert-buffer t t)
		      )
		  ))
	      )
	  )
	)
    )
)

(defun file-strip-suffix (file)
  "Return FILE without its file suffix."
  (if (string-match "\\.[^./]+$" file)
      (substring file 0 (match-beginning 0))
    file))

(defun file-get-suffix (file)
  "Return the file suffix for FILE, or NIL if none."
  (if (string-match "\\.\\([^./]+\\)$" file)
      (substring file (match-beginning 1) (match-end 1))))

;(defvar headers-loaded nil "headers")
;(if headers-loaded 
;    nil
;  (add-hook 'find-file-hooks 'create-header)
;  (setq headers-loaded t))
;
;(defun create-header()
;  (interactive())
;  (if (and buffer-file-name (string= (file-get-suffix (buffer-name)) "c"))
;      (progn
;	 (setq the-buffer-name (buffer-name))
;	 (setq header-file (concat (file-strip-suffix (buffer-file-name)) ".h"))
;
;	 (if (not (file-exists-p header-file))
;	     (progn
;	       (setq res (read-from-minibuffer (format (concat "Create " header-file " ? "))))
;	       (if (or (string= res "y")
;		       (string= res "yes"))
;		   (progn
;		     (save-buffer)
;		     (find-file header-file)
;		     (save-buffer)
;		     (switch-to-buffer the-buffer-name)
;		     ))
;	       ))
;	 ))
;)
;
;(defun switch-to-buffer-header()
;  (interactive())
;  (setq the-buffer (read-buffer "Switch to and open header of : "))
;  (if (string= (file-get-suffix the-buffer) "c")
;      (progn
;	 (delete-other-windows)
;	 (split-window-horizontally)
;	 (switch-to-buffer the-buffer)
;	 (setq the-name (file-strip-suffix buffer-file-name))
;	 (other-window 1)
;	 (find-file (concat the-name ".h"))
;	 (other-window -1))
;    (switch-to-buffer the-buffer))
;)
;
