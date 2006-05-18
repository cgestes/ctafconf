;;
;; generic-menu.el
;; Login : <ctaf@localhost.localdomain>
;; Started on  Thu May 18 02:10:36 2006 GESTES Cedric
;; $Id$
;; 
;; Copyright (C) @YEAR@ GESTES Cedric
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
;;; generic-menu.el --- convenience functions to define buffer oriented menus

;; Copyright (C) 2000 Olaf Sylvester

;; Author: Olaf Sylvester <Olaf.Sylvester@netsurf.de>
;; Maintainer: Olaf Sylvester <Olaf.Sylvester@netsurf.de>
;; Keywords: convenience

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
;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to the
;; Free Software Foundation, Inc., 59 Temple Place - Suite 330,
;; Boston, MA 02111-1307, USA.

;;; Commentary:

;; Version: 0.1
;; X-URL: http://www.geekware.de/software/emacs

;; This packages provides a generic function `gm-popup' for
;; building buffer oriented menus.


;; Example:
;; 
;;  (gm-popup :elements '("I" "like" "emacs") 
;;            :select-callback (lambda (val) 
;;                               (message "You hace selected: %S" val)))
;;
;; Pop up a menu with displays three elements for selection.
;; If doing a selection with RET a message will appear.

;;; Customization:

;;; History:
;; 

;;; Code:

;; ----------------------------------------------------------------------------
;; Variables for customization
;; ----------------------------------------------------------------------------

;; ----------------------------------------------------------------------------
;; Variables for internal use only
;; ----------------------------------------------------------------------------

(defvar gm-properties nil
  "Alist of properties of generic menu.
Is local to all buffers created for generic menu.")

(defvar gm-mode-hook nil
  "Hook when installing mode `gm-mode'.")

(defvar gm-mode-map ()
  "Keymap of `gm-mode'.")

;; (makunbound 'gm-properties-defaults )
(defvar gm-properties-defaults 
  '((:header-line . "Make a selection:")
    (:buffer-name . "*Generic Menu*")
    (:display-string-function . (lambda (element) (format "%s" element))))
  "Alist of defaults for some properties.")

;; (if (and nil gm-mode-map)
(if gm-mode-map
    ()
  (setq gm-mode-map (make-sparse-keymap))

  (let ((key ?1))
    (while (<= key ?9)
      (define-key gm-mode-map (char-to-string key) 'digit-argument)
      (setq key (1+ key))))

  (define-key gm-mode-map "-"       'negative-argument)
  (define-key gm-mode-map "\e-"     'negative-argument)

  (define-key gm-mode-map " "       'gm-down)
  (define-key gm-mode-map "\C-m"    'gm-select)
  (define-key gm-mode-map [up]      'gm-up)
  (define-key gm-mode-map [down]    'gm-down)
  (define-key gm-mode-map "p"       'gm-up)
  (define-key gm-mode-map "n"       'gm-down)
  (define-key gm-mode-map "u"       'gm-update-current-line)
  (define-key gm-mode-map "g"       'gm-refresh)
  (define-key gm-mode-map "G"       'gm-full-refresh)
  (define-key gm-mode-map "?"       'gm-help)
  (define-key gm-mode-map "\C-g"    'gm-abort)
  (define-key gm-mode-map "q"       'gm-quit))

;; ----------------------------------------------------------------------------
;; Generic Menu functions
;; ----------------------------------------------------------------------------

(defun gm-property (name &optional non-exists-default nil-default props)
  "Return property with name NAME of assoc `gm-properties'.
Return default value NON-EXISTS-DEFAULT if value does not exists in
`gm-properties'.  Use NIL-DEFAULT if value exists and is nil.
If PROPS is non nil use PROPS instead of `gm-properties'."
  (let ((value (assoc name (or props gm-properties))))
    (if value
	(or (cdr value) nil-default)
      non-exists-default)))

(defun gm-set-property (name value)
  "Set property with name NAME to value VALUE in property list `gm-properties'."
  (let ((assoc (assoc name gm-properties)))
    (if assoc (setcdr assoc value)
      (setq gm-properties (cons (cons name value)
				gm-properties)))))

(defun gm-set-properties (properties)
  "Set `gm-properties' to PROPERTIES."
  (setq gm-properties properties))

(defun gm-mode (&optional properties)
  "Major mode for editing generic menus.
\\<gm-mode-map>
Aside from a header lines each line describes a special value.
Leave buffer by \\[gm-quit].  Abort buffer list by \\[gm-abort].

For faster navigation each digit key is a digit argument.

\\[gm-quit]   -- Leave Desktop Menu.
\\[gm-help]   -- Display this help text.
Optional argument PROPERTIES: Property list for `gm-properties'."
  (interactive)
  (kill-all-local-variables)
  (use-local-map gm-mode-map)
  (if (gm-property ':font-lock-keywords)
      (progn
	(make-local-variable 'font-lock-defaults)
	(make-local-variable 'font-lock-verbose)
	(setq font-lock-defaults
	      (list (gm-property :font-lock-keywords) t)
	      font-lock-verbose nil)))
  (make-local-variable 'gm-properties)
  (setq gm-properties properties)
  (setq major-mode 'gm-mode
	mode-name (gm-property :mode-name "Generic Menu")
	buffer-read-only t
	truncate-lines (gm-property :truncate-lines nil t))
  (run-hooks 'gm-mode-hook)
  (let ((hooks-name (gm-property :mode-hook-name)))
    (if hooks-name
	(run-hooks (eval hooks-name)))))

(defun gm-list-entries (header elements insert-fun)
  "Fill current buffer with header line HEADER and elements ELEMENTS.
Inserts the result of applying INSERT-FUN on each elements in ELEMENTS."
  (let ((inhibit-read-only t))
    (insert header "\n")
    (while elements
      (gm-insert-one-entry (car elements) insert-fun)
      (insert "\n")
      (setq elements (cdr elements)))
    (backward-delete-char 1)
    (set-buffer-modified-p nil)
    (if (gm-property ':font-lock-keywords)
	(font-lock-fontify-buffer))
    (beginning-of-buffer)))

(defun gm-insert-one-entry (element insert-fun)
  "Insert in current buffer the display string for ELEMENT.
Therefore apply function INSERT-FUN on ELEMENTS.
Don't insert a newline."
  (insert (funcall insert-fun element)))

(defun gm-lines-element ()
  "Return current lines element."
  (let ((line (count-lines (point-min) (line-beginning-position))))
    (if (and (>= line 1)
	     (<= line (length (gm-property :elements))))
	(nth (1- line) (gm-property :elements))
      (error "You aren't on a valid line"))))

(defun gm-refresh ()
  "Redisplay all elements."
  (interactive)
  (let ((inhibit-read-only t))
    (erase-buffer)
    (gm-list-entries (gm-property :header-line)
		     (gm-property :elements)
		     (gm-property :display-string-function
				  'identity))
    (gm-goto-start-position)))

(defun gm-full-refresh ()
  "Recompute and redisplay all elements."
  (interactive)
  (let ((inhibit-read-only t))
    (if (gm-property :revert-elements-function)
	(gm-set-property :elements 
			 (funcall (gm-property :revert-elements-function))))
    (gm-refresh)
    (shrink-window-if-larger-than-buffer)))

(defun gm-update-nth-line (n)
  "Update the display string of N'th element."
  (save-excursion
    (goto-line n)
    (beginning-of-line)
    (let ((element (gm-lines-element))
	  (inhibit-read-only t)
	  )
      (delete-region (point) (line-end-position))
      (gm-insert-one-entry element (gm-property :display-string-function
						'identity)))))

(defun gm-update-current-line ()
  "Update the display string of current lines element."
  (interactive)
  (gm-update-nth-line (1+ (count-lines (point-min) 
				       (line-beginning-position)))))

(defun gm-up (arg)
  "Move cursor vertically up ARG lines in Desktop Menu."
  (interactive "p")
  (if (> 0 arg)
      (gm-down (- arg))
    (let ((arg (mod arg (length (gm-property :elements))))
	  (lines (count-lines (point-min) (line-beginning-position))))
      (if (>= arg lines)
	  (gm-down (- (count-lines (point-min) (point-max))
				(1+ arg)))
	(previous-line arg)))))

(defun gm-down (arg)
  "Move cursor vertically down ARG lines in Desktop Menu."
  (interactive "p")
  (if (eq 0 (count-lines (point-min) (line-beginning-position))) 
      ;; on first line
      (progn (next-line 1)
	     (setq arg (1- arg))))
  (if (> 0 arg)
      (gm-up (- arg))
    (let ((arg (mod arg (length (gm-property :elements))))
	  (lines (count-lines (line-beginning-position) (point-max))))
      (if (>= arg lines)
	  (gm-up (- (count-lines (point-min) (point-max)) arg 1))
	(next-line arg)))))

(defun gm-quit ()
  "Leave generic menu.
Further do some clean up actions defined in property :quit-action."
  (interactive)
  (if (gm-property :quit-action)
      (funcall (gm-property :quit-action)))
  (bury-buffer (current-buffer))
  (set-window-configuration (gm-property :window-config-comming-from)))

(defun gm-abort ()
  "Ding and leave generic menu without doinf any clean up actions."
  (interactive)
  (ding)
  (bury-buffer (current-buffer))
  (set-window-configuration (gm-property :window-config-comming-from)))

(defun gm-find-file ()
  "Find file with current lines value."
  (interactive)
  (find-file (gm-lines-element)))

(defun gm-select ()
  "Apply callback in property :select-callback on cuurent lines value."
  (interactive)
  (let ((callback (gm-property :select-callback)))
    (if callback
	(funcall callback (gm-lines-element))
      (error "You havn't defined a callback. Use property :select-callback"))))

(defun gm-help ()
  "Help for `gm-mode'."
  (interactive)
  (describe-function 'gm-mode)
  (let ((helpstring (gm-property :mode-help)))
    (with-current-buffer "*Help*"
      (let ((inhibit-read-only t))
	(save-excursion
	  (goto-char (point-max))
	  (delete-region (line-beginning-position) (point))
	  (insert (or helpstring "No further help.")))))))

(defun gm-plain-to-properties (plain-properties)
  "Convert a plist property PLAIN-PROPERTIES list to a alist."
  (let ((res nil))
    (while plain-properties
      (setq res (cons (cons (car plain-properties)
			    (car (cdr plain-properties)))
		      res))
      (setq plain-properties
	    (cdr (cdr plain-properties))))
    (reverse res)))

(defun gm-goto-start-position ()
  "Goto a start position defined for generic menu.
This function is used after displaying all elements to go to a suitable
position for further navigation.  This position is defined
by property :goto-start-position-function (a function called
without any arguments) or :regexp-start-position, a regular expression
with specifies the position to go to.
:goto-start-position-function takes precedence."
  (interactive)
  (let ((fun (gm-property ':goto-start-position-function))
	(goto-regexp (gm-property ':regexp-start-position)))
    (if fun
	(funcall fun)
      (if goto-regexp
	  (if (search-forward-regexp goto-regexp nil t)
	      (goto-char (match-beginning 0)))
	(next-line 1)))))

(defun gm-popup (&rest plain-properties)
  "Make a generic menu with plist PLAIN-PROPERTIES.
Pop up an new buffer with property :elements as menu entries.
Available properties:
:elements -- Elements which are represented each by one line.
:display-string-function  -- Function which (needs one parameter).
:select-callback -- Function called when doing a selection with `gm-select'.
:revert-elements-function -- function for recalculating all elements.
:regexp-start-position    -- For details see function `gm-goto-start-position'.
:goto-start-position-function -- For details see
function `gm-goto-start-position'.
:mode-help   -- Extra help string.
:quit-action -- A function.  Action when quitting
:header-line -- String for header line.
:mode-hook-name     -- Symbol which holds the hooks for mode `gm-mode'.
:font-lock-keywords -- font lock definition.
:truncate-lines -- whether truncating lines.
:mode-name   -- Name of mode for generic menu.
:buffer-name -- Name of buffer for generic menu.
:keymap      -- extra keymap for overriding already defined key strokes
           or defining new additional key bindings."
  
  (let ((properties (gm-plain-to-properties plain-properties))
	(defaults gm-properties-defaults))
    (while defaults
      (if (null (gm-property (car (car defaults)) nil nil properties))
	  (setq properties 
		(cons (cons (car (car defaults))
			    (cdr (car defaults)))
		      properties)))
      (setq defaults (cdr defaults)))
    (let ((buffer (get-buffer-create (gm-property :buffer-name
						  nil
						  nil
						  properties))))
      (set-buffer buffer)
      (gm-mode (append properties
		       (list (cons :window-config-comming-from
				   (current-window-configuration)))))
      (let ((override-map (gm-property :keymap)))
	(if override-map
	    (let ((copied-keymap (copy-keymap override-map)))
	      (derived-mode-merge-keymaps gm-mode-map copied-keymap)
	      (use-local-map copied-keymap))))
      (let ((inhibit-read-only t))
	(erase-buffer)
	(gm-list-entries (gm-property :header-line)
			 (gm-property :elements)
			 (gm-property :display-string-function 
				      'identity)))
      (pop-to-buffer buffer)
      (gm-goto-start-position)
      (shrink-window-if-larger-than-buffer))))

 
(provide 'generic-menu)

;;; generic-menu.el ends here
