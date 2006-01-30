;;
;; test.emacs for ctafconf in /home/ctaf/IBC/batail_s-ibc2
;;
;; Made by GESTES Cedric
;; Login   <ctaf@epita.fr>
;;
;; Started on  Mon Jan 16 01:09:16 2006 GESTES Cedric
;; Last update Sat Jan 28 01:35:42 2006 GESTES Cedric
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

(defvar running-xemacs (string-match "XEmacs" (emacs-version)))
(defvar running-fsfemacs (string-match "GNU Emacs" (emacs-version)))
(defvar running-windows (eq window-system 'windows))
(setq
      ;; autosave
  ;;    auto-save-directory (expand-file-name "~/autosave/")
  ;;    auto-save-directory-fallback auto-save-directory
  ;;    auto-save-hash-p nil

  ;;    efs-auto-save t
  ;;    efs-auto-save-remotely nil
  ;;    efs-nslookup-program "/usr/bin/nslookup -silent"
      ;; now that we have auto-save-timeout, let's crank this up
      ;; for better interactive response.
  ;;    auto-save-interval 0
  ;;    auto-save-timeout 0

)

;; This is here to avoid hitting X FSF bytecode incompatibilities
;; *.el in ~/lib/emacs is simply ln -s'ed to X or FSF subdir and
;; then bytecompiled
;;(setq my-lib-path (if running-xemacs
;;                      (expand-file-name "~/lib/emacs/X")
;;                    (expand-file-name "~/lib/emacs/FSF")))

;;(setq load-path (cons my-lib-path load-path))

(defun byte-compile-specific-files ()
  (dolist (name (directory-files my-lib-path t ".el$"))
    (byte-compile-file name)))

defun good-buffer-p (&optional buffer)
  (let ((buffer-name (buffer-name buffer)))
    (or (member buffer-name '("*scratch*" "*cvs*"))
        (not (string-match "^ ?\\*.*\\*$" buffer-name)))))

(defun my-kill-this-buffer-and-window ()
  (interactive)
  (kill-this-buffer)
  (if (= (count-windows) 2) (delete-window))
  (or (good-buffer-p)
      (switch-to-buffer
       (or (find-if 'good-buffer-p (buffer-list)) "*scratch*"))))

(defun my-recompile ()
  (interactive)
  (let ((compilation-ask-about-save nil))
    (recompile)))

;; buffer cycling
(autoload 'cycle-buffer "cycle-buffer" "Cycle forward." t)
(autoload 'cycle-buffer-backward "cycle-buffer" "Cycle backward." t)
(autoload 'cycle-buffer-permissive "cycle-buffer" "Cycle forward allowing *buffers*." t)
(autoload 'cycle-buffer-backward-permissive "cycle-buffer"
  "Cycle backward allowing *buffers*." t)
(autoload 'cycle-buffer-toggle-interesting "cycle-buffer"
  "Toggle if this buffer will be considered." t)

;;http://www.boblycat.org/~malc/.emacs
