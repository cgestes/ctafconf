;; auto-template.el
;;
;; LCD Archive Entry:
;; auto-template|Kevin Broadey|kevin@edscom.demon.co.uk|
;; Auto insert templates with macro replacement based on file extension.|
;; 92-11-02|1.0|~/misc/auto-template.el.Z|
;;
;; Originally Written by Kevin Broadey <kbroadey@edscom.demon.co.uk>
;;
;; Hacked another time by Gary W. Flake <peyote@umiacs.umd.edu>
;;   My notes and additions have a (GWF) next to them.
;;
;; Version 2.0  16-Oct-93
;;
;; Overview (GWF):
;;  Auto-template is pretty much a poor man's dmacro.  If you need to bind
;;  things to key strokes then you should use dmacro.  However, if you are
;;  like me, and normally just use the template features of dmacro, then
;;  you may find that this package does everything you want, but is a bit
;;  easier to use.
;;
;;
;; Changes in version 2.0 (GWF):
;;  - We now use auto-template-alist to match files by a regular expression
;;    instead of the filename-suffix.  Thus, we can now handle makefiles.
;;  - Commonly used strings are now computed automatically.  The variable
;;    and the expressions used are contained in auto-template-function-alist.
;;  - Template filenames now end in ".tpl" but substitution filenames still
;;    end in ".sub".  The base name is in the cdr portion of
;;    auto-template-alist (the car contains the regular expression).
;;  - If either the template file or the substitution files don't exist we
;;    quit silently.
;;
;; Read the DOC string for usage information.
;;
;; Based on template.el by Tom Lord <lord+@andrew.cmu.edu>.  I added the stuff
;; for running from find-file-hooks and generally hacked it beyond all
;; recognition.
;;
;;
;; Usual GNU copyleft stuff.
;;
;; Mail me with bug reports and suggestions.
;;
;; Mail me anyway if you like the package so I can feel all warm inside.


(provide 'auto-template)

(defvar auto-template-dir "~/emacs-version/templates/")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defvar auto-template-loaded nil
  "This exists so that we only do some things once.")

(if auto-template-loaded
    nil
  (add-hook 'find-file-hooks 'auto-template)
  (setq auto-template-loaded t))

(defvar auto-template-alist
  '(("\\.\\(la\\)?tex$"		. "tex")
    ("\\.[xcm]$"		. "c")
    ("\\.\\(ch\\|eh\\|ih\\)$"	. "c")
    ("\\.h$"			. "h")
    ("\\.cpp$"			. "cc")
    ("\\.\\(cc\\|C\\)$"		. "cc")
    ("\\.java$"			. "java")
    ("\\.php$"			. "php")
    ("\\.\\(hh\\|H\\)$"		. "hh")
    ("\\.\\(hxx\\|H\\)$"	. "hxx")
    ("\\.el$"			. "el")
    ("\\.e$"			. "e")
    ("\\.sh$"			. "sh")
    ("\\.pl$"			. "pl")
    ("\\.rb$"			. "rb")
    ("\\.py$"			. "py")
    ("\\.html$"			. "html")
    ("\\.tcl$"			. "tcl")
    ("\\.ml\\w?$"		. "ml")
    ("\\.ad\\(b\\|s\\)$"	. "ada")
    ("\\.ml\\w?$"		. "ml")
    ("[Mm]akefile$"		. "makefile")
    ("\\.mk$"			. "makefile")
    ("\\.yy$"			. "yy")
    ("\\.sieve$"		. "sieve")
    ("Makefile.am$"		. "am")
    )
  "Alist specifying text to insert by default into a new file.
Elements look like (REGEXP . BASENAME); if the new file's name
matches REGEXP, then the file BASENAME.tpl is inserted into the
buffer with substitutions specified in BASENAME.sub.
Only the first matching element is effective.")

(defvar auto-template-function-alist
  '((tpl-file-name  . (file-name-nondirectory (buffer-file-name)))
    (tpl-directory  . (file-name-directory (buffer-file-name)))
    (tpl-day        . (substring (current-time-string) 8 10))
    (tpl-user-login . (user-login-name))
    (tpl-user-name  . (user-full-name))
    (tpl-date-stamp . (current-time-string))
    (tpl-host       . (system-name))
    (tpl-year       . (substring (current-time-string) 20))
    (tpl-month      . (substring (current-time-string) 4 7))
    (tpl-date       . (substring (current-time-string) 0 3))
    (tpl-hour       . (substring (current-time-string) 11 13))
    (tpl-minute     . (substring (current-time-string) 14 16))
    (tpl-second     . (substring (current-time-string) 17 19)))
  "Alist specifying the global variable names and expressions that
set each variable.  Elements look like (NAME . EXPR); each call of
auto-template will set each variable NAME to the value of EXPR.")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun auto-template (&optional template-file)
  "Insert the contents of TEMPLATE-FILE after point.  Mark is set at the
end of the inserted text.  If a \"substitutions file\" exists and is
readable, the substitutions are applied to the inserted text.  The
default directory for TEMPLATE-FILE is `auto-template-dir'.

A substitutions file has the same base name as TEMPLATE-FILE and suffix
\".sub\".  Each line looks like:-

    \"@PLACE-HOLDER@\"      (string-valued-sexp)
or
    \"@PLACE-HOLDER@\"      \"Prompt: \"

In the first case @PLACE_HOLDER@ is replaced by the value of the sexp,
and in the second the string is used as a prompt to read a replacement
string from the minibuffer.  If you would like to use a string valued
literal as a sexp simply prepend the string with a single quote, as in
'\"foobar\".

The format of the place-holder is entirely up to you.  Just remember to
choose something that it unlikely to appear for real in the template
file.  Also, because substitutions are performed in the order they
appear, if the replacement for an earlier place-holder contains a later
one, this too will be replaced.  This is a feature, not a bug!

To simplify the whole process, certain global variable are set on each
invocation of the function auto-template.  A list of the variables
follows, and the corresponding values should be self-explanatory.  By
convention all of these variable begin with the prefix \"tpl-\".

Here is the default list:
tpl-file-name, tpl-directory, tpl-day, tpl-user-login, tpl-user-name,
tpl-date-stamp, tpl-year, tpl-month, tpl-date, tpl-hour, tpl-minute,
and tpl-second.

If you'd like to add your own variable to this alist, simply append a
list in the form (VAR . EXPR) to auto-template-function-alist.

If you add this function to your `find-file-hooks' then when you visit a
new file it will automatically insert template file \"SUF.SUF\" from
`auto-template-dir', where SUF is the suffix for the new file.  It will
also apply substitutions file \"SUF.sub\" to the inserted text if it
exists and is readable.  Your `find-file-hooks' is modified automatically,
as of version 2.0."

  ;; I hacked this a bit.  This could be cleaned up some.  Sorry, elisp
  ;; is not my forte (GWF).
  ;;

  (interactive (list
		(let ((completion-ignored-extensions
		       (cons ".sub" completion-ignored-extensions)))
		  (read-file-name "Template file: " auto-template-dir nil t))))

  ;; If not called with a template file name, create one from the current
  ;; buffer's file name if this is a new file.

  (auto-template-set-globals)

  (if (or template-file
	  (file-exists-p (buffer-file-name)))
      nil

    (setq template-file (auto-template-assoc
                         (file-name-nondirectory (buffer-file-name))
                         auto-template-alist))
    (if (not template-file) nil
      (setq template-file (concat auto-template-dir template-file ".tpl"))
      ))

  ;; Do our stuff if we've got a template file.
  (if (and template-file (file-readable-p template-file))
      (let ((substitution-file (concat
				(auto-template-strip-suffix template-file)
				".sub")))
        (if (and substitution-file (file-readable-p substitution-file))
            (let ((original-buffer (current-buffer))
                  (work-buffer (get-buffer-create " *auto-template*"))
                  substitutions)
              ;;
  	      ;; Note - I use a temporary buffer even when there is no
	      ;; substitutions file so that UNDO makes a new file's buffer go back
	      ;; to `unmodified'.  This didn't happen when I used `insert-file' to
	      ;; insert the file directly into the buffer - undo removed the text
	      ;; but left the buffer flagged as modified.
              ;;
              (set-buffer work-buffer)
              (widen)
              (erase-buffer)

	      ;; Read substitutions into a list if the file is readable.
              (if (file-readable-p substitution-file)
                  (progn
                    (insert "()")		; list delimiters
                    (forward-char -1)
                    (insert-file-contents substitution-file)
                    (goto-char (point-min))
                    (setq substitutions (read work-buffer))))

              ;; Read in the template file.
              (erase-buffer)
              (insert-file-contents template-file)

              ;; Apply the substitutions.
              (while substitutions
                (let ((place-holder (car substitutions))
                      (replacement (car (cdr substitutions))))
                  (setq substitutions (cdr (cdr substitutions)))
                  (setq replacement
                        (if (stringp replacement)
                            (read-string replacement)
                          (eval replacement)))
                  (save-excursion
                    (while (search-forward place-holder nil t)
                      (replace-match replacement t t)))
                  ))

              ;; Insert the (possibly modified) template.
              (set-buffer original-buffer)
              (insert-buffer work-buffer)
              (kill-buffer work-buffer)
              )))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun auto-template-get-suffix (file)
  "Return the file suffix for FILE, or NIL if none."
  (if (string-match "\\.\\([^./]+\\)$" file)
      (substring file (match-beginning 1) (match-end 1))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun auto-template-strip-suffix (file)
  "Return FILE without its file suffix."
  (if (string-match "\\.[^./]+$" file)
      (substring file 0 (match-beginning 0))
    file))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; (GWF)

(defun auto-template-assoc (file alist)
  "Return the basename of the pattern in ALIST which maches FILE."
  (let* (basename)
    (while (and alist (not basename))
      (if (string-match (car (car alist)) file)
          (setq basename (cdr (car alist)))
        (setq alist (cdr alist))))
    basename))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; (GWF)

(defun auto-template-set-globals ()
  "Sets the auto-template global variables to some useful things."
  (let* ((alist auto-template-function-alist))
    (while alist
      (set (car (car alist)) (eval (cdr (car alist))))
      (setq alist (cdr alist)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
