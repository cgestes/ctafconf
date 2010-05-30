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
(setq auto-template-dir "~/.config/ctafconf/etc/emacs/templates/")
(safe-load "auto-template")

;; Compilation Options
(setq compile-command "make -k")
;; little compilation window
(setq compilation-window-height 12)

(safe-load "yasnippet-bundle")

;;gud/gdb settings
(require 'gdb-ui)

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

;;update copyright years in headers
(add-hook 'before-save-hook 'copyright-update)

;;Display potential error in red
;;PS: check for: if (bla);   and if (bla = bla)
(global-cwarn-mode t)

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

;;provide the sieve mode
(autoload 'sieve-mode "sieve" "major mode for sieve" t)
(add-to-list 'auto-mode-alist '("\\.siv$" . sieve-mode))
(add-to-list 'auto-mode-alist '("\\.sieve$" . sieve-mode))

;;provide the tiger mode
(autoload 'tiger-mode "tiger" "major mode for tiger" t)
(add-to-list 'auto-mode-alist '("\\.tig$" . tiger-mode))

;;provide the lua mode
(autoload 'lua-mode "lua-mode" "major mode for lua" t)
(add-to-list 'auto-mode-alist '("\\.lua$" . lua-mode))

;;provide the haskell mode
(autoload 'haskell-mode "haskell-site-file" "major mode for haskell" t)
(add-to-list 'auto-mode-alist '("\\.hs" . haskell-mode))

;;tuareg-mode CAML
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

;;AsciiDoc
(autoload 'doc-mode "doc-mode" "major asciidoc mode" t)
(add-hook 'doc-mode-hook
	  '(lambda ()
	     (turn-on-auto-fill)
	     (require 'asciidoc)))
(add-to-list 'auto-mode-alist '("\\.asciidoc$"        . doc-mode))


;; provide cedet
;; (condition-case err
;;     (progn

;;       (setq semantic-load-turn-useful-things-on t)
;;       ;;(setq semantic-load-turn-everything-on t)
;;       (load-file "~/.config/ctafconf/etc/emacs/site-lisp/cedet/common/cedet.el")
;;       ;;(load-file "~/src/cedet/common/cedet.el")
;;       ;; * This turns on which-func support (Plus all other code helpers)
;;       (semantic-load-enable-excessive-code-helpers)
;;       ;; (semantic-load-enable-guady-code-helpers)

;;       ;;S-SPC for autocompletion
;;       ;;(global-set-key '[33554464] 'semantic-complete-analyze-inline)
;;       (global-set-key '[33554464] 'semantic-complete-analyze-and-replace)
;;       ;;(global-set-key '[33554464] 'semantic-ia-complete-symbol)

;;       ;;          (global-set-key '[C-f1] 'semantic-ia-describe-class)
;;       ;;          (global-set-key '[C-f1] 'semantic-ia-show-doc)
;;       (global-set-key '[C-f1] 'semantic-ia-show-summary)
;;       ;;          (global-semantic-show-parser-state-mode 1)
;;       (global-semantic-decoration-mode 1)
;;       (global-srecode-minor-mode 1)
;;       (global-semantic-stickyfunc-mode 0)
;;       ;;load the projet management mode
;;       ;;           (global-ede-mode 1)
;;       ;;display a bar with the function name the cursor is in
;;       ;;          (global-semantic-stickyfunc-mode 1)
;;       ;;(setq semanticdb-default-save-directory "~/.emacs.d/semantic")
;;       ;;(global-semantic-idle-completions-mode 1)
;;       ;;(global-semantic-highlight-edits-mode 1)
;;       ;;(global-semantic-show-unmatched-syntax-mode 0)
;;       ;; (global-highlight-changes 1)
;;       ;; (highlight-changes-rotate-faces)
;;       ;; (setq highlight-changes-colours
;;       ;;   '("yellow" "magenta" "blue" "maroon" "firebrick" "green4" "DarkOrchid"))
;;       )
;;   (error
;;    (message "Cannot load CEDET %s" (cdr err))))


;;provide ecb

(defun ctafconf-ecb ()
  (condition-case err
        (progn
          (setq ecb-auto-activate t)
          (setq ecb-tip-of-the-day nil)
          ;;(require 'ecb nil t)
          (require 'ecb-autoloads)
          )
      (error
       (message "Cannot load ecb %s" (cdr err))))
  )

