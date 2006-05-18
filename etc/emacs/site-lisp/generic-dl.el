;; Copyright (C) 2000 by Olaf Sylvester

;; Author:  Olaf Sylvester <olaf@geekware.de>
;; Keywords: convenience
;; Version: 0.1

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; A copy of the GNU General Public License can be obtained from this
;; program's author (send electronic mail to kyle@uunet.uu.net) or from
;; the Free Software Foundation, Inc., 675 Mass Ave, Cambridge, MA
;; 02139, USA.
;;

;;; Commentary:
;; Provide a function for listing toplevel definitions in
;; current buffer according to current mode.
;;
;; Install:
;; 1)  Put generic-dl.el and generic-menu.el into a suitable place.
;; 2a) When in load-path
;;     (require 'generic-dl)
;; 2b) When not in load-path
;;     (load "/WHERE_IT_IS/generic-menu.el")
;;     (load "/WHERE_IT_IS/generic-dl.el")
;; 3) Define a suitable key
;;     (global-set-key [f8] 'dl-popup)


;;; History:
;;

(require 'generic-menu)

;;; Code:
;;(makunbound 'dl-mode-descriptions)
(defvar dl-mode-descriptions
  '(
    (emacs-lisp-mode :toplevel-matches
		     (("^(defun\\s +\\(.*\\)\\s +(" ("  Function %s" 1))
		      ("^(def\\(var\\|custom\\)\\s +\\(.*\\)" ("  Variable %s" 2))
		      ;;("^;;;\\s *\\(.*\\)"           (" ;;; %s" 1))
		      )
		     :sort-function     (lambda (l1 l2) (string< (car l1) (car l2)))
		     :search-direction  forward)
    ))

(defun dl-description-for (buffer &optional safe-p)
  "Return description for dl for buffer BUFFER.
Optional argument SAFE-P specifies how to react if function can't
determine a dl description.  if non nil function will return nil.
Otherwise function will raise an error."
  (save-excursion
    (set-buffer buffer)
    (cond ((local-variable-if-set-p 'dl-description)
	   (symbol-value 'dl-description))
	  ((assoc major-mode dl-mode-descriptions)
	   (cdr (assoc major-mode dl-mode-descriptions)))
	  (imenu-generic-expression
	   (dl-imenu-generic-expression-to-dl-description imenu-generic-expression))
	  ((not safe-p)
	   (error "No toplevel description or imenu-generic-expression for mode %s"
		  major-mode))
	  (t nil))))

(defun dl-imenu-generic-expression-to-dl-description (expression)
  "Extract from a imenu line EXPRESSION a suitable expression for this package.
Typically EXPRESSION a the value of `imenu-generic-expression' of a certain mode."
  (list :toplevel-matches
	(mapcar (lambda (imenu-des)
		  (list (cadr imenu-des)
			(list (concat "  "
				      (or (car imenu-des) "Function")
				      " %s" )
			      (caddr imenu-des))))
		expression)
	:search-direction 'forward
	:sort-function     (lambda (l1 l2) (string< (car l1) (car l2)))
	:remove-duplicates t))

;; Test (length (plist-get (dl-imenu-generic-expression-to-dl-description imenu-generic-expression) :toplevel-matches))

;; Test: (dl-description-for (current-buffer))
;; Test: (dl-description-for "*scratch*")

(defun dl-extract-definitions-for (description buffer &optional start end)
  "Extract all toplevel definitions described by DESCRIPTION in buffer BUFFER.
Narrow to region defined by START and END."
  (let* ((result nil)
	 (strings nil)
	 (remove-duplicates   (plist-get description :remove-duplicates))
	 (matchers   (plist-get description :toplevel-matches))
	 (backward-p (eq 'backward (plist-get description :search-direction)))
	 (search-function (if backward-p
			      'search-backward-regexp
			    'search-forward-regexp))
	 (goto-start-function (if backward-p 'point-max 'point-min)))
    (with-current-buffer buffer
      (save-restriction
	(widen)
	(save-excursion
	  (save-match-data
	    (narrow-to-region (or start (point-min)) (or end (point-max)))
	    (while matchers
	      (goto-char (funcall goto-start-function))
	      (let ((matcher (car matchers)))
		(while (funcall search-function (car matcher) nil t)
		  (let ((display-string (dl-build-description-string
					 (caadr matcher)
					 (cdadr matcher))))
		    (unless (and remove-duplicates
				(member display-string strings))
		      (setq result
			    (cons (list display-string (match-beginning 0))
				  result)
			    strings (cons display-string strings))))));while let
	      (setq matchers (cdr matchers)))))))
    (reverse result)))

;; Test (dl-extract-definitions-for (dl-description-for (current-buffer)) (current-buffer))

(defun dl-sorted-definitions (description buffer &optional start end)
  "Extract and sort all toplevels described by DESCRIPTION in buffer BUFFER.
Narrow to region defined by START and END.  Assert a value for current point."
  (let ((res (dl-extract-definitions-for description buffer start end)))
    (sort (cons (list "****" (point)) res)
	  (lambda (e1 e2)
	    (< (cadr e1) (cadr e2))))))

(defun dl-restricted-definitions (description buffer startpoint)
  "Extract all toplevel definitions described by DESCRIPTION in buffer BUFFER.
Used region arround point STARTPOINT."
  (let ((pre-region-size (plist-get  description :pre-region-size))
	(post-region-size (plist-get description :post-region-size)))
    (dl-sorted-definitions description
			   buffer
			   (if pre-region-size
			       (max (point-min) (- startpoint pre-region-size))
			     (point-min))
			   (if post-region-size
			       (min (point-max) (+ startpoint post-region-size))
			     (point-max)))))

(defun dl-build-description-string-helper (value &optional string)
  "Helper to instantiate inside VALUE numbers to values of last match of STRING.
Example:
(progn (string-match \"\\\\(hello\\\\)\\\\s *\\\\(world\\\\)\" \"hello  world\")
       (dl-build-description-string-helper '(concat (capitalize 1) \" \" 2)
                                           \"hello  world\"))
returns \"Hello world\"."
  (cond ((integerp value)
	 (or (match-string value string) ""))
	((consp value)
	 (apply (car value)
		(mapcar (lambda (val)
                          (dl-build-description-string-helper val string))
			(cdr value))))
	(t value)))

(defun dl-build-description-string (format args)
  "Create an string according to current match and format string FORMAT.
Argument ARGS is a list of integers which specify the match string of
the current match."
  (cond ((symbolp format)
	 (apply format args))
	((numberp format)
	 (match-string format))
	(t (let ((strings (mapcar (function dl-build-description-string-helper)
				  args)))
	     (apply 'format format strings)))))


(defun dl-goto-position ()
  "Extract the position of current lines value and goto according position.
Leave current selection menu and select according buffer and goto position."
  (interactive)
  (let ((post-goto-hook (gm-property :post-goto-hook))
	(position (cadr (gm-lines-element)))
	(buffer (gm-property :buffer)))
    (gm-quit)
    (set-buffer buffer)
    (goto-char position)
    (if post-goto-hook
	(funcall post-goto-hook))))


(defun dl-popup ()
  "Pop up a buffer with toplevel descriptions."
  (interactive)
  (let* ((buffer      (current-buffer))
	 (description (dl-description-for (current-buffer)))
	 (map         (make-sparse-keymap))
	 (insert-fun  (function (lambda (list)
				 (car list)))))
    (define-key map "v"    'dl-verbose)
    (define-key map " "    'dl-goto-position)
    (define-key map "\C-m" 'dl-goto-position)
    (gm-popup :buffer            buffer
              :header-line      (concat "Toplevels in " (buffer-name))
	      :elements         (dl-restricted-definitions
				            description (current-buffer)
					    (point))
	      :buffer-name      "*Toplevel Definitions*"
	      :mode-name        "*Toplevel Definitions*"
	      :display-string-function insert-fun
	      :keymap           map
	      :regexp-start-position "^\\*\\*\\*"
	      :post-goto-hook   (plist-get description :post-goto-hook)
	      :description      description
	      :sort-function    (plist-get description :sort-function)
	      :mode-help        "Help me for help!"
	      )))

(defun dl-verbose ()
  (interactive)
  (message "%S" (gm-lines-element)))

;;(global-set-key "\C-x\C-y" 'dl-popup)

(provide 'generic-dl)

;;; generic-dl.el ends here
