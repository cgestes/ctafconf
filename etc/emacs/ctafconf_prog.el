;;
;; prog.emacs for ctafconf in /home/ctaf/IBC/batail_s-ibc2
;;
;; Made by GESTES Cedric
;; Login   <ctaf42@gmail.com>
;;
;; Started on  Mon Jan 16 01:14:21 2006 GESTES Cedric
;; Last update Tue May 25 18:56:10 2010 Cedric GESTES
;;
(message ".")
(message "ctafconf loading: PROG.EMACS")


;;file extension mode
(setq auto-mode-alist
      (append
       '(
         ("\\.dat$"             . text-mode)
         ("\\.pas$"             . pascal-mode)
         ("\\.java$"            . c-mode)
         ("\\.doc$"             . plain-tex-mode)
         ("\\.bib$"             . bibtex-mode)
         ("\\.bst$"             . bst-mode)
         (".emacs$"             . emacs-lisp-mode)
         ("emacs*"              . emacs-lisp-mode)
         ("*emacs$"             . emacs-lisp-mode)
         ("\\.tcsh*"            . csh-mode)
         ("\\.[ly]$"            . c-mode) ;; bison/flex
         ("\\.Xdefaults$"       . xrdb-mode)
         ("\\.Xenvironment$"    . xrdb-mode)
         ("\\.Xresources$"      . xrdb-mode)
         ("\\.txt$"             . text-mode)
         ("\\.bb$"              . sh-mode)
         ("\\.bbclass$"         . sh-mode)
         ("\\.ebuild$"          . sh-mode)
         ("\\.eclass$"          . sh-mode)
         ("\\SConscript$"       . python-mode)
         ("\\SConstruct$"       . python-mode)
         ("\\.css$"             . css-mode)
         ("\\.cfm$"             . html-mode)
         ("\\.pl$"              . perl-mode)
         ) auto-mode-alist))


;;auto-template for .cc, .c, .h, .hh, ...
(setq auto-template-dir (concat ctafconf-path "templates/"))
(safe-load "auto-template")

;; Compilation Options
(setq compile-command "make -k")
;; little compilation window
(setq compilation-window-height 12)
;;remove compilation windows when there is no error, after 2sec
(add-hook 'compilation-finish-functions
          (lambda (buf str)
            (if (string-match "exited abnormally" str)
                (next-error)
              ;;no errors, make the compilation window go away in a few seconds
              (run-at-time "2 sec" nil 'delete-windows-on (get-buffer-create "*compilation*"))
              (message "No Compilation Errors!")
              )
            ))

(safe-load "yasnippet-bundle")

;;gud/gdb settings
;;(require 'gdb-ui)
;;use many frame
(setq gdb-many-windows t)
;;separate program io from gdb command line
;;(setq gdb-use-separate-io-buffer t)
;;if gdb stop in a frame where we cant find the source file
;;go up in the stack till source are found
(setq gdb-find-source-frame t)
;;echo the value of var in the echo area
;;(setq gud-tooltip-echo-area t)

;; kill trailing white space on save
(add-hook 'write-file-hooks 'delete-trailing-whitespace)

;;c/c++ : autoappend * when in /* */ comment
(autoload 'blockcomment-mode         "block-comm" "" t)
(autoload 'turn-on-blockcomment-mode "block-comm" "" t)
(add-hook 'c-mode-hook   'turn-on-blockcomment-mode)
(add-hook 'c++-mode-hook 'turn-on-blockcomment-mode)

;;DoxyMacs
(autoload 'doxymacs-font-lock "doxymacs" "doxymacs minor mode" t)
(autoload 'doxymacs-mode      "doxymacs" "doxymacs minor mode" t)
(defun my-doxymacs-font-lock-hook ()
  (if (or (eq major-mode 'c-mode) (eq major-mode 'c++-mode))
      (doxymacs-font-lock)))
(add-hook 'c-mode-common-hook  'doxymacs-mode)
(add-hook 'font-lock-mode-hook 'my-doxymacs-font-lock-hook)

;;provide the tiger mode
(autoload 'tiger-mode "tiger" "major mode for tiger" t)
(add-to-list 'auto-mode-alist '("\\.tig$" . tiger-mode))

;;provide the lua mode
(autoload 'lua-mode "lua-mode" "major mode for lua" t)
(add-to-list 'auto-mode-alist '("\\.lua$" . lua-mode))

;;provide the haskell mode
(add-to-list 'load-path (concat ctafconf-path "site-lisp/mode/haskell-mode-2.7.0"))
(autoload 'haskell-mode "haskell-site-file" "major mode for haskell" t)
(add-to-list 'auto-mode-alist '("\\.hs" . haskell-mode))

;;tuareg-mode CAML
(add-to-list 'load-path (concat ctafconf-path "site-lisp/mode/tuareg"))
(autoload 'tuareg-mode "tuareg"    "Major mode for editing Caml code" t)
(autoload 'camldebug   "camldebug" "Run the Caml debugger" t)
(add-to-list 'auto-mode-alist '("\\.ml\\w?" . tuareg-mode))

;;Eiffel
(autoload 'eiffel-mode "eiffel-mode" "Major mode for Eiffel programs" t)
(add-to-list 'auto-mode-alist '("\\.e\\'" . eiffel-mode))

;;ADA
(autoload 'ada-mode    "ada-mode" "Major mode for Ada programs" t)
(add-to-list 'auto-mode-alist '("\\.adb\\'" . ada-mode))
(add-to-list 'auto-mode-alist '("\\.ads\\'" . ada-mode))

;;Protobuff
(autoload 'protobuf-mode "protobuf-mode" "major mode for protobuf" t)
(add-to-list 'auto-mode-alist '("\\.proto$" . protobuf-mode))

;;Cmake
(autoload 'cmake-mode "cmake-mode" "major cmake mode" t)
(add-to-list 'auto-mode-alist '("CMakeLists\\.txt\\'" . cmake-mode))
(add-to-list 'auto-mode-alist '("\\.cmake\\'"         . cmake-mode))

;;AsciiDoc
(autoload 'doc-mode "doc-mode" "major asciidoc mode" t)
(add-hook 'doc-mode-hook
	  '(lambda ()
	     (turn-on-auto-fill)
	     (require 'asciidoc)))
(add-to-list 'auto-mode-alist '("\\.asciidoc$"        . doc-mode))


(defun ctafconf-semantic ()
  (if (boundp 'semantic-mode)
      (condition-case err
          (progn
            (semantic-mode t)
            (global-semanticdb-minor-mode          1)
            (global-semantic-idle-scheduler-mode   1)
            (global-semantic-idle-summary-mode     1)
            ;;(global-semantic-idle-completions-mode t)
            (global-semantic-highlight-func-mode   1)
            (global-semantic-decoration-mode       1)
            (global-semantic-stickyfunc-mode       0)
            (global-semantic-mru-bookmark-mode     1)
            ))
      (error
       (message "Cannot load ecb %s" (cdr err))))
    )
(ctafconf-semantic)

(defun ctafconf-ropemacs ()
  (condition-case err
      (progn
        (let ((newpypath (concat (getenv "PYTHONPATH")  ":" ctafconf-path "site-lisp/python/Pymacs")))
          (setenv "PYTHONPATH" newpypath)
          (message "PYTHONPATH set to: %s" newpypath)
          )

          (add-to-list 'load-path (concat ctafconf-path "site-lisp/python/Pymacs"))

          (set 'pymacs-load-path (list (concat ctafconf-path "site-lisp/python/Pymacs")
                                       (concat ctafconf-path "site-lisp/python/rope")
                                       (concat ctafconf-path "site-lisp/python/ropemode")
                                       (concat ctafconf-path "site-lisp/python/ropemacs")))
          )
        (require 'pymacs)
        (pymacs-load "ropemacs" "rope-")
        (setq ropemacs-guess-project  t)
        (setq ropemacs-confirm-saving nil)
    (error
     (message "Cannot load ropemacs %s" (cdr err))))
  )
(ctafconf-ropemacs)


;;very good completion (using semantic, etags, ...)
(add-to-list 'load-path (concat ctafconf-path "site-lisp/company-0.5"))
(safe-load "company")

(defun complete-or-indent ()
  (interactive)
  (if (company-manual-begin)
      (company-complete-common)
    (indent-according-to-mode)))

(defun indent-or-complete ()
  (interactive)
  (if (looking-at "\\_>")
      (company-complete-common)
    (indent-according-to-mode)))

(if (boundp 'global-company-mode)
    (progn
      (global-company-mode 1)
      ;; only complete when inserting char (otherwize completion popup when browsing code)
      (setq company-begin-commands '(self-insert-command))
      (global-set-key "\t" 'indent-or-complete)
))



;;weird, recall ropemacs setting after company (that use and load ropemacs)
(setq ropemacs-guess-project  t)
(setq ropemacs-confirm-saving nil)
(setq ropemacs-enable-autoimport t)

;;provide ecb
(defun ctafconf-ecb ()
  (condition-case err
        (progn
          (add-to-list 'load-path (concat ctafconf-path "site-lisp/ecb"))
          (setq ecb-primary-secondary-mouse-buttons 'mouse-1--mouse-2)
          (setq ecb-options-version "2.40")
          (require 'ecb)
          ;; (setq ecb-auto-activate t)
          (setq ecb-tip-of-the-day nil)
          (setq ecb-vc-enable-support t)
          (setq ecb-options-version "2.40")
          ;; ;;(require 'ecb nil t)
          ;; (require 'ecb-autoloads)
          )
      (error
       (message "Cannot load ecb %s" (cdr err))))
  )
(ctafconf-ecb)

;; add the index menu to each mode support that (showing function/var/class of the current buffer)
(defun try-to-add-imenu ()
  (condition-case nil (imenu-add-menubar-index) (error nil)))
(add-hook 'font-lock-mode-hook 'try-to-add-imenu)


;;foldable region display clickable +/- mark in the fringe
(autoload 'hideshowvis-enable "hideshowvis" "Highlight foldable regions")
(dolist (hook (list 'c-mode-common-hook 'emacs-lisp-mode-hook 'java-mode-hook 'lisp-mode-hook 'perl-mode-hook 'sh-mode-hook 'python-mode-hook))
  (add-hook hook 'hideshowvis-enable))

;;Display potential error in red
;;PS: check for: if (bla);   and if (bla = bla)
;;conflict with new emacs (24.0.50 git)
;;(global-cwarn-mode t)
