;;
;; test.emacs for ctafconf in /home/ctaf/IBC/batail_s-ibc2
;;
;; Made by GESTES Cedric
;; Login   <ctaf@epita.fr>
;;
;; Started on  Mon Jan 16 01:09:16 2006 GESTES Cedric
;; Last update Mon Jan 16 02:10:03 2006 GESTES Cedric
;;
(message "ctafconf loading: TEST.EMACS")

;;(setq load-path (cons "~/.ctafconf/etc/emacs/site-lisp/" load-path))

;;(require 'tex-site)
;;(require 'mpg123)
;;(require 'un-define)
;;(require 'bar-cursor)
;;(require 'crypt++)
;;; This rulez
;;(require 'boxquote)
;;(require 'gnugo)
;;(require 'emvaders)
;;; for editing the .Xdefaults file
;;(require 'xrdb-mode)


;;; Wrapper to make .emacs self-compiling.
;; (defvar init-top-level t)
;; (if init-top-level
;;     (let ((init-top-level nil))
;;       (if (file-newer-than-file-p "~/.emacs" "~/.emacs.elc")
;;           (progn
;;             (load "~/.emacs")
;; 	    ;;(delete-file "~/.emacs.elc")
;; 	    (byte-compile-file "~/.emacs")
;; 	    (load "~/.emacs.elc")
;; 	    ;; Delete the following line if necessary:
;; 	    ;;            (rename-file "~/.emacsc" "~/.emacs.elc" t)
;;             )
;;         (load "~/.emacs.elc")))
;;(progn



;;(delete-file "~/.emacs.elc")
;;     <current .emacs file here>

;;eviter les pb de chargement (fichier portable)
;; (require 'foo)
;;=>
;; (require 'foo nil t)
;; (foo-mode 1)
;;=>
;; (when (fboundp 'foo-mode) (foo-mode 1))
;; '(current-language-environment "Latin-1")
;; '(default-input-method "latin-1-prefix")

;;LEARN one key:
;;M-x global-set-key
;;C-x ESC ESC (affiche la commande precedente nikel chrome)

;;TEST FOR OS TYPE
;;(cond ((eq system-type 'darwin)
;;       ()
;;))
;;;;PATH













;;
;;
;;
;;
;; (global-set-key "\C-t\C-h" 'insert-function-header)

;; ;; indent the entire buffer
;; (defun c-indent-buffer ()
;;   "Indent entire buffer of C source code."
;;   (interactive)
;;   (save-excursion
;;     (goto-char (point-min))
;;     (while (< (point) (point-max))
;;       (c-indent-command)
;;       (end-of-line)
;;       (forward-char 1))))

;; (defun insert-function-header () (interactive)
;;   (insert "  /*///////////////////////////////////*/\n")
;;   (insert "  /**\n")
;;   (insert "   * \n")
;;   (insert "   * @param: \n")
;;   (insert "   * @return: \n")
;;   (insert "   */\n"))

;; (global-set-key "\C-t\C-g" 'insert-file-header)

;;;; Abbreviations ;;;;
;; (setq-default abbrev-mode t)
;; (setq save-abbrevs t
;;       abbrev-file-name (expand-file-name "abbrevs" my-emacsdir)
;;       ;; Free up space in the mode line by removing the "Abbrev" string.
;;       minor-mode-alist
;;       (delq (assq 'abbrev-mode minor-mode-alist) minor-mode-alist))

;; (if (file-exists-p abbrev-file-name) (quietly-read-abbrev-file))

;; ;; Avoid the annoying "Save abbrevs in... ?" prompt.
;; (defun my-abbrevs-save ()
;;   "Save the abbreviations file if it has changed.
;; Intended for use with `my-before-kill-emacs-hook'."
;;   (when (and abbrevs-changed save-abbrevs)
;;     (write-abbrev-file abbrev-file-name)
;;     (setq abbrevs-changed nil)))

;; (add-hook 'my-before-kill-emacs-hook 'my-abbrevs-save)

;;permet la completion?
;;(require 'completion nil t)
;;(initialize-completions)
