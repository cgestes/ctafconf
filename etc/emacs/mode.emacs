;;
;; mode.emacs for ctafconf in ~/.config/ctafconf/etc/emacs/mode.emacs
;;
;; Made by GESTES Cedric
;; Login   <ctaf42@gmail.com>
;;
;; Started on  Mon Jan 16 00:57:16 2006 GESTES Cedric
;; Last update Tue Dec 18 12:45:05 2007 GESTES Cedric
;;
(message ".")
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
         ("\\SConscript$"   . python-mode)
         ("\\SConstruct$"   . python-mode)
         ("\\.css$" . html-mode)
         ("\\.cfm$" . html-mode)
         ("\\.ml\\w?" . tuareg-mode)
         ("\\.adb\\'" . ada-mode)
         ("\\.ads\\'" . ada-mode)
         ("\\.e\\'" . eiffel-mode)
         ) auto-mode-alist))


;;IDO MODE
;;IDO for find-file, and others
(condition-case err
    (progn
      (require 'ido nil t)
      (ido-mode t)
      (global-set-key "\C-x\C-b" 'ido-switch-buffer)
      (setq ido-auto-merge-work-directories-length -1)
      )
  (error
   (message "Cannot load ido %s" (cdr err))))

;;disable iswitchb
(if (iswitchb-mode nil)
    (iswitchb-mode nil)
    )

(global-set-key "\C-xb" 'electric-buffer-list)

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
;; REENABLE WHEN LESS MY SHELL CONF WILL BE LESS BUGGY (root write in /home/ctaf/.emacs-place)
;; (condition-case err
;;     (progn
;;       (require 'saveplace)
;;       (setq-default save-place t)
;;       )
;;   (error
;;    (message "Cannot load saveplace %s" (cdr err))))


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
      (require 'tabbar)
      (tabbar-mode t)
      )
  (error
   (message "Cannot load tabbar %s" (cdr err))))

(condition-case err
    (progn
      ;;for lot's of unix configuration file, fstab, ...
      (require 'pc-keys)
      )
  (error
   (message "Cannot load pc-keys %s" (cdr err))))

(condition-case err
    (progn
      ;;for lot's of unix configuration file, fstab, ...
      (require 'generic)
      (require 'generic-x)
      )
  (error
   (message "Cannot load generic %s" (cdr err))))


;;screensaver
(defun ctafconf-zone()
    (condition-case err
        (progn
          (when (>= emacs-major-version 21)
            (require 'zone)
            (setq zone-idle 300)
            (zone-when-idle 300))
          )
      (error
       (message "Cannot load zone-mode %s" (cdr err))))
  )

(if enable-zone
    (ctafconf-zone))

