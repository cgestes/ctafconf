;;
;; mode.emacs for ctafconf in ~/.ctafconf/etc/emacs/mode.emacs
;;
;; Made by GESTES Cedric
;; Login   <ctaf@epita.fr>
;;
;; Started on  Mon Jan 16 00:57:16 2006 GESTES Cedric
;; Last update Tue Feb  6 06:32:04 2007 GESTES Cedric
;;
(message "ctafconf loading: MODE.EMACS")

;;file extension mode
(setq auto-mode-alist
      (append
       '(
         ("\\.txt$" . text-mode)
         ("\\.dat$" . text-mode)
         ("\\.pas$" . pascal-mode)
         ("\\.java$" . c-mode)
         ("\\.doc$" . plain-tex-mode)
         ("\\.bib$" . bibtex-mode)
         ("\\.bst$" . bst-mode)
         (".emacs$" . emacs-lisp-mode)
         ("emacs*" . emacs-lisp-mode)
         ("*emacs$" . emacs-lisp-mode)
         ("\\.tcsh*" . csh-mode)
         ("\\.[ly]$" . c-mode) ;; bison/flex
         ("\\.Xdefaults$"    . xrdb-mode)
         ("\\.Xenvironment$" . xrdb-mode)
         ("\\.Xresources$"   . xrdb-mode)
         ("\\.css$" . html-mode)
         ("\\.cfm$" . html-mode)
         ("\\.ml\\w?" . tuareg-mode)
         ("\\.adb\\'" . ada-mode)
         ("\\.ads\\'" . ada-mode)
         ("\\.e\\'" . eiffel-mode)
         ) auto-mode-alist))


;;cicles through element in M-x, C-x f, etc...
(condition-case err
    (progn
      (require 'icicles)
      (setq icicle-reminder-prompt-flag 0
            icicle-arrows-respect-completion-type-flag t)
      (icicle-mode t)
      )
  (error
   (message "Cannot load icicles %s" (cdr err))))

;;IDO MODE
;;IDO for find-file, and others
(condition-case err
    (progn
      (require 'ido nil t)
      (ido-mode t)
      (global-set-key "\C-x\C-b" 'ido-switch-buffer)
      )
  (error
   (message "Cannot load ido %s" (cdr err))))

;;;;dont know!
;; (condition-case err
;;     (progn
;;       (when (require 'ibuffer "ibuffer" t)
;; 	(setq ibuffer-shrink-to-minimum-size t)
;; 	;;(setq ibuffer-always-show-last-buffer ':nomini)
;; 	(setq ibuffer-always-show-last-buffer nil)
;; 	(setq ibuffer-sorting-mode 'recency)
;; 	(setq ibuffer-use-header-line t)
;; 	(setq ibuffer-formats '((mark modified read-only " " (name 30 30)
;; 				      " " (size 6 -1) " " (mode 16 16) " " filename)
;; 				(mark " " (name 30 -1) " " filename)))
;; 	(define-key ibuffer-mode-map (kbd "#") 'ibuffer-switch-format))
;;         ;;need to be after ido-mode
;;         (iswitchb-mode 1)
;;       )
;;   (error
;;    (message "Cannot load ibuffer %s" (cdr err))))


(global-set-key "\C-xb" 'electric-buffer-list)

;; better home and end keybindings
;;(condition-case err
;;    (progn
;;      (require 'pc-keys)
;;      )
;;  (error
;;   (message "Cannot load pc-keys %s" (cdr err))))


;; indent =, <, ... in cmode
;;(require 'smart-operator)
;; (defun my-c-mode-common-hook()
;;   (smart-insert-operator-hook)
;;
;;   (local-unset-key (kbd "."))
;;   (local-unset-key (kbd ":"))
;;   (local-set-key (kbd "*") 'c-electric-star))
;;
;; (add-hook 'c-mode-common-hook 'my-c-mode-common-hook)


;; this mode let you use emacs with the "modern editor bindings"
;; shift + left|right|up|down to make a selection
;; ctrl x, ctrl v, ctrl c
(condition-case err
    (progn
      ;;C-return => selection mode
      (if (boundp 'cua-mode)
          ;; For 21.3.50 and higher
          (cua-mode t)
        ;; For earlier emacs
        (load "cua")
        (CUA-mode t)))

  (error
   (message "Cannot load cua %s" (cdr err))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;BOOKMARK
  ;; Make sure the repository is loaded as early as possible (for desktop-read)
(condition-case err
    (progn
      (setq bm-restore-repository-on-load t)
      (require 'bm)
      (setq-default bm-buffer-persistence t)
      ;; Restoring bookmarks when on file find.
      (add-hook 'find-file-hooks 'bm-buffer-restore)
      ;; Saving bookmark data on killing a buffer
      (add-hook 'kill-buffer-hook 'bm-buffer-save)
      ;; Saving the repository to file when on exit.
      ;; kill-buffer-hook is not called when emacs is killed, so we
      ;; must save all bookmarks first.  Ignore errors, so that Emacs
      ;; doesn't become unkillable.
      (add-hook 'kill-emacs-hook
                '(lambda nil (condition-case nil
                                 (progn
                                   (bm-buffer-save-all)
                                   (bm-repository-save)))))
      ;; Update bookmark repository when saving the file.
      (add-hook 'after-save-hook 'bm-buffer-save)
      ;; Restore bookmarks when buffer is reverted.
      (add-hook 'after-revert-hook 'bm-buffer-restore))
  (error
   (message "Cannot load bm %s" (cdr err))))

;; Gives us marker-visit-next and marker-visit-prev
(condition-case err
    (progn
      (require 'marker-visit))
  (error
   (message "Cannot load marker-visit %s" (cdr err))))

;;highlight current line
;;(hl-line-mode)

(condition-case err
    (progn
      ;; setnu (Show line numbers)
      (autoload 'setnu-mode "setnu+" "Line Numbers." t)
      )
  (error
   (message "Cannot autoload setnu-mode %s" (cdr err))))



;;;SavePlace- this puts the cursor in the last place you editted
;;;a particular file. This is very useful for large files.
(condition-case err
    (progn
      (require 'saveplace)
      (setq-default save-place t)
      )
  (error
   (message "Cannot load saveplace %s" (cdr err))))


;; (autoload 'html-helper-mode "html-helper-mode" "Yay HTML" t)
;;                     (load-library "hhm-config")
;;                     (setq auto-mode-alist (cons '("\\.html$" . html-helper-mode) auto-mode-alist))
;;                     (setq auto-mode-alist (cons '("\\.asp$" . html-helper-mode) auto-mode-alist))
;;                     (setq auto-mode-alist (cons '("\\.phtml$" . html-helper-mode) auto-mode-alist))


;;EMACSFOLDING
(condition-case err
    (progn
      (require 'hideshow)
      (require 'outline)
      (require 'fold-dwim)

      ;;use folding or outline when programming
      (mapcar '(lambda (hook)
                 (add-hook hook
                           '(lambda () (progn (hs-minor-mode 1)))))
              '(c-mode-hook
                c++-mode-hook
                sh-mode-hook
                java-mode-hook
                css-mode-hook
                php-mode-hook
                ))

      (mapcar '(lambda (hook)
                 (add-hook hook
                           '(lambda () (progn (outline-minor-mode)))))
              '(emacs-lisp-mode-hook
                perl-mode-hook
                python-mode-hook
                lisp-mode-hook
                ))

       ;; Search in comments as well as "code"
      (setq hs-isearch-open t)
      (setq hs-hide-comments-when-hiding-all t)
      (setq hs-allow-nesting t)

      ;; Expand any hidden blocks on goto-line
      (defadvice goto-line (after expand-after-goto-line
                                  activate compile)
        "hideshow-expand affected block when using goto-line in a collapsed buffer"
        (save-excursion
          (hs-show-block)))
      )
  (error
   (message "Cannot load folding %s" (cdr err))))


(condition-case err
    (progn
      (require 'browse-kill-ring)
      )
  (error
   (message "Cannot load browse-kill-ring %s" (cdr err))))

(condition-case err
    (progn
      ;;for lot's of unix configuration file, fstab, ...
      (require 'generic)
      (require 'generic-x)
      )
  (error
   (message "Cannot load generic %s" (cdr err))))




