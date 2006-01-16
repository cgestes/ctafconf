;;
;; interfaces.el
;; Login : <mandor@agone>
;; Started on  Wed Nov 13 22:40:34 2002 mandor
;; $Id: interfaces.el,v 1.3 2002/11/15 09:13:57 marmotte Exp $
;;
;; Copyright (C) @YEAR@ mandor
;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2 of the License, or
;; (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program; if not, write to the Free Software
;; Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
;;



(defvar setget_set "\nvoid\tset_\\2(\\1 _set_get_val)\n\{\\2 = _set_get_val; }\n")
(defvar setget_get "\\1&\tget_\\2()\n{ return \\2;}\n")
(defvar setget_get_const "const\t&\\1\tget_\\2()\tconst\n{ return \\2;}\n\n")

(defvar old_pos)
(defvar end)
(defvar begin)
(defvar ID)


(defun runsetget()

  (setq ID "//setget")
  (setq old_pos (point-marker))
  (print old_pos)
  (goto-char (marker-position old_pos))
  (print (point-marker))
;  (narrow-to-region (line-beginning-position()) (line-end-position()))
  (copy-region-as-kill (line-beginning-position()) (line-end-position()))

;  (beginning-of-buffer)
;  (print  (line-beginning-position()))
;  (print  (line-end-position()))
  (setq begin (line-beginning-position()))
  (replace-regexp  '"\\(.*\\)\\W+\\(\\w+\\);" (concat
					       setget_set
					       setget_get
					       setget_get_const
					       )
		   nil
		   (- (line-beginning-position()) 1) 
		   (+ (line-end-position()) 1)
		   )
  (setq end (line-end-position()))
  (beginning-of-buffer)
  (if (not (search-forward ID nil t 1))
      (setq ID "public:")) 
  (dosetget)
  (makunbound `old_pos)
  (makunbound `begin)
  (makunbound `end)
  (makunbound `ID)
  )



(defun dosetget()
;  (setq end (line-end-position()))
  (kill-region begin end)
 ; (widen)
  (beginning-of-buffer)
  (print old_pos)
  (if (equal major-mode 'c++-mode)
      (search-forward ID nil t 1))
  (yank 1)
  (print old_pos)
  (goto-char (marker-position old_pos))
  (print old_pos)
  (goto-char (marker-position old_pos))
  (yank 2)
					; (reindent-file)
  )


(defun setjava()
  "Set the Java Directives"
  (setq setget_set "\npublic void\tset_\\2(\\1 _set_get_val)\n\{\\2 = _set_get_val; }\n")
  (setq setget_get "public \\1\tget_\\2()\n{ return \\2;}\n")
  (setq setget_get_const "")  
  )

(defun setget()
  "Function to create langage Set/Get function for a declared variable"
  (interactive)
  (if (equal major-mode 'java-mode)
      (setjava)
    ())
  (if (or (equal major-mode 'c++-mode) (equal major-mode 'java-mode))
      (runsetget)
    )
  )

