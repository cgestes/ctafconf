;;
;; autoinsert.el
;; 
;; Made by (jb)
;; Login   <jb@hydra>
;; 
;; Started on  Sun Sep 16 00:37:44 2001 jb
;; Last update Thu Mar  7 02:50:58 2002 Samuel Pasquier
;;

;===================== autoinsert =====================
; Auto-insert text when making new *.cpp, *.cc, *.h files.


(defvar auto-insert-directory)
(defvar auto-insert-query nil)
(defvar auto-insert-alist)

(add-hook 'find-file-hooks 'auto-insert)
(setq auto-insert-directory "~/emacs-config/autoinsert/")
(setq auto-insert-query nil)
(setq auto-insert-alist
      '(("\\main.cpp$"	. ["main.cpp" auto-update-source-file])
	 ("\\main.cc$"	. ["main.cc" auto-update-source-file])
	 ("\\.cpp$"	. ["cpp" auto-update-source-file])
	 ("\\.cc$"	. ["cc" auto-update-source-file])
	 ("\\.hpp$"	. ["hpp" auto-update-header-file])
	 ("\\.hh$"	. ["hh" auto-update-header-file])
	 ("\\.pro$"	. ["pro" auto-update-project-file])))

; If you create a file called Test.hpp, this function will replace:
;
;   @@@ with TEST
;   ||| with Test
;
; The first one is useful for #ifdefs, the second one for the header
; description, for example.

(defun auto-update-header-file ()
  (save-excursion
    (while (search-forward "@@@" nil t)
      (save-restriction
	 (narrow-to-region (match-beginning 0) (match-end 0))
	 (replace-match
	  (upcase
	   (file-name-sans-extension
	    (file-name-nondirectory buffer-file-name)))))))
  (save-excursion
    (while (search-forward "|||" nil t)
      (save-restriction
	 (narrow-to-region (match-beginning 0) (match-end 0))
	 (replace-match
	  (file-name-sans-extension
	   (file-name-nondirectory buffer-file-name)))))))

; If you create a file called Test.cpp, this function will replace:
;
;   @@@ with TEST
;   ||| with Test
;
; The first one is useful for #ifdefs, the second one for the header
; description, for example.

(defun auto-update-source-file ()
  (save-excursion
    (while (search-forward "@@@" nil t)
      (save-restriction
	 (narrow-to-region (match-beginning 0) (match-end 0))
	 (replace-match
	  (upcase
	   (file-name-sans-extension
	    (file-name-nondirectory buffer-file-name)))))))
  (save-excursion
    (while (search-forward "|||" nil t)
      (save-restriction
	 (narrow-to-region (match-beginning 0) (match-end 0))
	 (replace-match
	  (file-name-sans-extension
	   (file-name-nondirectory buffer-file-name))))))

)

; If you create a file called Test.pro, this function will replace:
;
;   @@@ with test
;   ||| with Test
;
; It will also create a directory for objects if a OBJECTS_DIR is present

(defun auto-update-project-file ()
  (save-excursion
    (while (search-forward "@@@" nil t)
      (save-restriction
	 (narrow-to-region (match-beginning 0) (match-end 0))
	 (replace-match
	  (downcase
	   (file-name-sans-extension
	    (file-name-nondirectory buffer-file-name)))))))
  (save-excursion
    (while (search-forward "OBJECTS_DIR" nil t)
      (save-excursion
	 (search-forward "=" nil t)
	 (save-restriction
	   (if (not(file-exists-p "obj" ))
	       (make-directory "obj"))))))
  (save-excursion
    (while (search-forward "|||" nil t)
      (save-restriction
	 (narrow-to-region (match-beginning 0) (match-end 0))
	 (replace-match
	  (file-name-sans-extension
	   (file-name-nondirectory buffer-file-name))))))
  (save-buffer)
  (shell-command (concat "tmake -o Makefile " buffer-file-name)))

