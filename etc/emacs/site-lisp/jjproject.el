;;; jjproject.el ---  persistence between sessions

;;----------------------------------------------
;; Joerg Arndt's  emacs startup files
;; ... online at http://www.jjj.de/
;; your feedback is welcome  mailto: arndt (AT) jjj.de
;; version: 2005-February-19 (21:48)
;;----------------------------------------------

;;; Commentary:
;; 

;;; History:
;; 

;;; Code:



;;; PROJECT file name:
(defconst jj-project-file "./.files-jjproject.el")

(defun jjj-load-project ()
  "If a project file exists in the current directory, load it."
  (interactive)
    (if (file-exists-p jj-project-file)
        (progn
          (message "%s" (concat "Loading project file " jj-project-file))
          (load-file jj-project-file) )
      (message "%s" (concat "No project file " jj-project-file " found") )
      ) )

;; contents of an example project file:
; (find-file "/tmp/shiftadd-log-out.txt") (goto-line 20) (goto-column 25) (recenter)
; (find-file "/tmp/mac-gray-7.txt") (goto-line 63) (goto-column 18) (recenter)
; (find-file "/tmp/shiftadd-exp-out.txt") (goto-line 22) (goto-column 24) (recenter)

(defun jjj-write-project ()
  "Write project file that can later be loaded so all files currently open are revisited."
  (interactive)
  (save-excursion
    (let
        (pstr)
      (setq pstr ";;; generated project file\n")
      (dolist (buffer (buffer-list))
        (with-current-buffer buffer
          (let ((file (buffer-file-name buffer))
                (line (number-to-string (jjj-get-line)))
                (col (number-to-string (jjj-get-col))) )
            (if (not (eq file nil))
                (setq pstr
                      (concat pstr
                              "(find-file \"" file "\")"
                              " (goto-line " line ")"
                              " (goto-column " col ")"
                              " (recenter)" "\n")
                      ) ) ; if
            ) ) ) ; dolist
;; (current-frame-configuration) has no read syntax ...:
;;      (print (current-frame-configuration) )
;;      (setq pstr (concat pstr ";; (set-frame-configuration "  "`"
;;              (prin1-to-string (current-frame-configuration) t)
;;              (format "%S" (current-frame-configuration))
;;              (with-output-to-string (set-frame-configuration
;;                                      (current-frame-configuration)))
;;              ")\n") )
;;      (setq pstr (concat pstr ";; (set-frame-configuration (car (read-from-string "
;;                         "\""
;;                         (prin1-to-string (current-frame-configuration))
;;                         "\""
;;                         " ) ) )\n") )

      ;;
      (find-file jj-project-file)
      (kill-region (point-min) (point-max))
      (insert pstr)
      (save-buffer)
      (kill-this-buffer)
      ) ) )


(provide 'jjproject)

;;; jjproject.el ends here
