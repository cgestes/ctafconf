;;
;; std_comment.el for std_comment.el in
;;
;; Made by jb
;; Login   <jb@epita.fr>
;;
;; Started on  Wed Oct 31 23:15:49 2001 jb
;; Last update Sat Jun  1 03:09:36 2002 Pepe
;;

(setq header-made-by "Made by ")
(setq header-login   "Login   ")
(setq header-login-beg "<")
(setq header-login-mid "@")
(setq header-login-end ">")
(setq header-started "Started on  ")
(setq header-for " for ")
(setq header-in " in ")
(setq domaine-name  "epita.fr")
(if (setq user-nickname (getenv "USER_NICKNAME"))
    t
  (setq user-nickname (user-full-name))
)
(setq header-last    "Last update ")
(setq header-last-on "Last Modified On: ")
(setq header-last-by "Last Modified By: ")
(setq write-file-hooks (cons 'update-std-header write-file-hooks))

(setq std-c-alist		'( (cs . "/*") (cc . "** ") (ce . "*/") ))
(setq std-cpp-alist		'( (cs . "//") (cc . "// ") (ce . "//") ))
(setq std-sscript-alist		'( (cs . "#")  (cc . "## ") (ce . "##") ))
(setq std-perl-alist		'( (cs . "#")  (cc . "## ") (ce . "##") ))
(setq std-makefile-alist        '( (cs . "##") (cc . "## ") (ce . "##") ))
(setq std-perl-alist	        '( (cs . "##") (cc . "## ") (ce . "##") ))
(setq std-lisp-alist		'( (cs . ";;") (cc . ";; ") (ce . ";;") ))
(setq std-fundamental-alist	'( (cs . "##") (cc . "## ") (ce . "##") ))
(setq std-java-alist		'( (cs . "/*") (cc . "** ") (ce . "*/") ))
(setq std-caml-alist		'( (cs . "(*") (cc . "** ") (ce . "*)") ))
(setq std-ada-alist		'( (cs . "--") (cc . "-- ") (ce . "--") ))
(setq std-tex-alist		'( (cs . "%%") (cc . "%% ") (ce . "%%") ))

(setq std-modes-alist '( ("C" . std-c-alist)
			 ("C++" . std-cpp-alist)
			 ("Lisp" . std-lisp-alist)
			 ("Lisp Interaction" . std-lisp-alist)
			 ("Emacs-Lisp" . std-lisp-alist)
			 ("Fundamental" . std-fundamental-alist)
			 ("Shell-script" . std-sscript-alist)
 			 ("Makefile" . std-makefile-alist)
			 ("Java" . std-java-alist)
			 ("Tuareg" . std-caml-alist)
			 ("Ada" . std-ada-alist)
			 ("LaTeX" . std-tex-alist)
 			 ("Perl" . std-perl-alist)
			 )
      )

(defun std-get (a)
  (interactive)
  (cdr (assoc a (eval (cdr (assoc mode-name std-modes-alist)))))
  )

(defun update-std-header ()
  "Updates std header with last modification time & owner.\n(According to mode)"
  (interactive)
  (let ((beg (point)))
    (if (buffer-modified-p)
	(progn
	  (goto-char (point-min))
	  (if (search-forward header-last nil t)
	      (progn
		(beginning-of-line)
		(kill-line)
		(rotate-yank-pointer 1)
		(insert-string (concat (std-get 'cc)
				       header-last
				       (current-time-string)
				       " "
				       user-nickname))
		(message "Last modification header field updated.")
		)
	    )
	  (goto-char (point-min))
	  (if (search-forward header-last-on nil t)
	      (progn
		(beginning-of-line)
		(kill-line)
		(rotate-yank-pointer 1)
		(insert-string (concat (std-get 'cc)
				       header-last-on
				       (current-time-string)))
		(message "Last modification header field updated.")
		)
	    )
	  (goto-char (point-min))
	  (if (search-forward header-last-by nil t)
	      (progn
		(beginning-of-line)
		(kill-line)
		(rotate-yank-pointer 1)
		(insert-string (concat (std-get 'cc)
				       header-last-by
				       user-nickname))
		(message "Last modification header field updated.")
		)
	    )
	  )
      )
    (goto-char beg)
    )
  nil
  )

(defun std-file-header ()
  "Puts a standard header at the beginning of the file.\n(According to mode)"
  (interactive)
  (goto-char (point-min))
  (let ((projname "")(location ""))
    (setq projname (read-from-minibuffer
		    (format "Type project name (RETURN to quit) : ")))
    (setq location (read-from-minibuffer
		    (format "Type file location (RETURN to quit) : ")))
    (insert-string (std-get 'cs))
    (newline)
    (insert-string (concat (std-get 'cc)
			   (buffer-name)
			   header-for
			   projname
			   header-in
			   location))
    (newline)
    (insert-string (std-get 'cc))
    (newline)
    (insert-string (concat (std-get 'cc) header-made-by user-nickname))
    (newline)
    (insert-string (concat (std-get 'cc)
			   header-login
			   header-login-beg
			   (getenv "USER")
			   header-login-mid
			   domaine-name
			   header-login-end))
    (newline)
    (insert-string (std-get 'cc))
    (newline)
    (insert-string (concat (std-get 'cc)
			   header-started
			   (current-time-string)
			   " "
			   user-nickname))
    (newline)
    (insert-string (concat (std-get 'cc)
			   header-last
			   (current-time-string)
			   " "
			   user-nickname))
    (newline)
    (insert-string (std-get 'ce))
    (newline)
    )
  )

(defun insert-std-vertical-comments ()
  "Inserts vertical comments (according to mode)."
  (interactive)
  (beginning-of-line)
  (insert-string (std-get 'cs))
  (newline)
  (let ((ok t)(comment ""))
    (while ok
      (setq comment (read-from-minibuffer
		     (format "Type comment (RETURN to quit) : ")))
      (if (= 0 (length comment))
	  (setq ok nil)
	(progn
	  (insert-string (concat (std-get 'cc) comment))
	  (newline)
	  )
	)
      )
    )
  (insert-string (std-get 'ce))
  (newline)
  )

(defun std-toggle-comment ()
  "Toggles line comment on or off (according to mode)."
  (interactive)
  (save-excursion
    (let (beg end)
      (beginning-of-line)
      (setq beg (point))
      (end-of-line)
      (setq end (point))
      (save-restriction
	(if (not (equal beg end))
	    (progn
	      (narrow-to-region beg end)
	      (goto-char beg)
	      (if (search-forward (std-get 'cs) end t)
		  (progn
		    (beginning-of-line)
		    (replace-string (std-get 'cs) "")
		    (replace-string (std-get 'ce) "")
		    )
		(progn
		  (beginning-of-line)
		  (insert-string (std-get 'cs))
		  (end-of-line)
		  (insert-string (std-get 'ce))
		  )
		)
	      )
	  )
	)
      )
    )
  ;;  (indent-according-to-mode)
  (indent-for-tab-command)
  (next-line 1)
  ;;  (indent-according-to-mode)
  )
