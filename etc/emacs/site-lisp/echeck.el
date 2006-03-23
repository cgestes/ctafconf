(defvar start)
(defvar diff)
(defvar nb)
(defvar col)
(defvar biglist)
(defvar alist)


(defun ec-bloc-count-line-msg ()
  "[Emacs-Check Epita] : Write if the current or previous function is less than 25 lines long"
  (interactive)
  (save-excursion
    (progn
      (setq start (point))
      (forward-sexp)
      (setq diff (count-lines (point) start))
      (if (<= diff 25)
	(progn
           (message "Count OK"))
	(progn
	  (message "Erreur %d lines"))))))

(defun ec-bloc-count-line ()
  "[Emacs-Check Epita] : Return the current bloc number of lines"
  (interactive)
  (save-excursion
    (progn
      (setq start (point))
      (forward-sexp)
      (count-lines (point) start))))

(defun ec-check-func-len ()
  "[Emacs-Check Epita] : Checks if the current or previous function is less than 25 lines long"
  (interactive)
  (save-excursion
    (progn
      (while
          (progn
            (search-backward "{")
            (setq col (current-column))
            (>= col 1)))
      (setq nb (ec-bloc-count-line))
      (if (<= nb 25)
          (message "OK (%d lines)" nb)
        (message "Erreur (%d lines)" nb)))))

(defun ec-line-count-char-msg ()
  "[Emacs-Check Epita] : Checks if the current line  is less than 80 chars long"
  (interactive)
  (save-excursion
    (progn
      (beginning-of-line)
      (setq start (point))
      (end-of-line)
      (setq diff (- (point) start))
      (if (>= diff 80)
          (message "Error %d chars !" diff)))))

(defun ec-main (start end len)
;  (interactive "P")
;  (ec-line-count-char-msg)
;  (ec-check-func-len)
  (if (ec-inside-macro)
    (message "inside macro")
    )
  )


(defvar ec-mode nil
  "Mode variable for [Emacs-Check Epita] minor mode")

(make-variable-buffer-local 'ec-mode)

(defun ec-mode(&optional arg)
 "[Emacs-Check Epita] minor mode"
 (interactive "P")
 (setq ec-mode (not ec-mode))
 (make-local-hook 'after-change-functions)
 (when font-lock-mode
   (font-lock-mode 0)
   (makunbound 'font-lock-keywords)
   (font-lock-mode 1))

 (if ec-mode
     (progn
       (message "ec mode on")
       (ec-highlight-regexps())
       (add-hook 'after-change-functions 'ec-main nil t)
       (font-lock-fontify-buffer))
   (progn
     (message "ec mode off")
     (remove-hook 'after-change-functions 'ec-main t)))

)

(defun ec-highlight-regexps(regexplist)

  (setq regexplist (list
   "[^ =+*/%<>!-]\\(=\\)"               ;pas n'importe quoi avant le =
   "\\(=\\)[^ =]"                       ;soit un espace soit un autre = apres un =
   "[^ ]\\(*\\||\\/\\)"			;pas d'espace avant operateur binaire pas unaire
   "\\(+\\|-\\|*\\||\\/\\)[^]-[+-*]"   	;pas d'espace apres operateur binaire
   "^\\(.................................................................................+\\)$"  ;pas plus de 80 car par ligne :)
   "\\(switch\\)"
   "\\(auto\\|continue\\|enum\\|short\\|volatile\\|break\\|default\\|extern\\|int\\|signed\\|typedef\\|case\\|do\\|float\\|long\\|sizeof\\|union\\|char\\|double\\|register\\|static\\|unsigned\\|const\\|else\\|goto\\|struct\\|void\\|for\\|if\\|while\\|return\\)[^ ]" ;detecte les mots clefs non suivis d'espaces
   "\\(for\\|if\\|while\\|return\\) [^(]"	;detecte les mots clefs non suivie de " ("
   "\\(( +\\)"					;detecte les espaces apres les (
   "\\( +)\\)"					;detecte les espaces avant les )
   "\\(,[^ \n]\\)"				;test apres virgule
   "\\( +,\\)"					;test avant virgule
   "\\( +;\\)"					;test avant ;
   "\\(;[^ \n]\\)"				;test apres ;
   "\\(,  +\\)"					;test >= 1 espace apres virgule
   "\\(; +\\)$"					;test ; suivi d'un espace en fin de ligne
   "\\(, +\\)$"					;test , suivi d'un espace en fin de ligne
   "\\(#define ?[a-z]+ \\)"			;test que define soit suivie de majuscule
   ))
  (setq biglist (list))
  (while regexplist
    (setq alist (cons (car regexplist) '(1 font-lock-warning-face t)))
    (setq biglist (append biglist (list alist)))
    (setq regexplist (cdr regexplist))
    )

  (font-lock-add-keywords  'nil  biglist)
  )



(defun ec-inside-macro ()
  "True if point is inside a C macro definition."
  (save-excursion
    (beginning-of-line)
    (while (eq (char-before (1- (point))) ?\\)
      (forward-line -1))
    (back-to-indentation)
    (eq (char-after) ?#)))
