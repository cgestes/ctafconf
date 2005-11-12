;;; tiger.el --- Mode for editing programs written in Appel's Tiger language.

;; Copyright (C) 2001  Edward O'Connor <ted@oconnor.cx>

;; Author: Edward O'Connor <ted@oconnor.cx>
;; Keywords: languages

;; This file is free software; you can redistribute it and/or modify
;; it under the terms of version 2 of the GNU General Public License
;; as published by the Free Software Foundation.

;; This file is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; I'm sure you already have many copies of the GPL on your machine.
;; If you're using GNU Emacs, try typing C-h C-c to bring it up. If
;; you're using XEmacs, C-h C-l does this.

;;; Commentary:

;; This mode only supports font-locking, unfortunately. If you'd like
;; to add functionality, please do so! :) You'll want to add something
;; like this to your .emacs file:

;; (require 'tiger)
;; (add-to-list 'auto-mode-alist '("\\.tig$" . tiger-mode))

;;; History:

;; In the Compilers class I took in college[0], we used Appel's
;; _Modern Compiler Implementation in Java_ text[1], in which he uses
;; the Tiger language. After a few weeks of our final project (which
;; was to write a Tiger compiler), I got sick of looking at
;; #c0c0c0-on-black Tiger text, and decided to hack up (at least) some
;; font-lock support for the language. Hence this file. I would have
;; added indenting stuff too, but the term ended and I graduated. :)
;; If you add functionality or whatever, please send me the changes;
;; I'll gladly maintain the code base or whatever. The latest version
;; can be found here: <URL:http://oconnor.cx/elisp/tiger.el>
;;
;;                                                              -- Ted
;;
;; 0. <URL:http://www.rose-hulman.edu/>
;; 1. <URL:http://www.cs.princeton.edu/~appel/modern/>

;;; Code:

(defgroup tiger nil
  "Tiger code editing commands for Emacs."
  :prefix "tiger-"
  :group 'languages)

(defconst tiger-font-lock-keywords
  `(
    ;; Tiger keywords.
    (,(concat "\\<\\(if\\|then\\|else\\|let\\|in\\|array\\|of\\|"
              "nil\\|while\\|do\\|to\\|for\\|break\\|end\\)\\>")
     (1 font-lock-keyword-face))

    ;; Function declarations.
    ("\\<\\(function\\)\\s-+\\(\\w+\\)\\s-*("
     (1 font-lock-keyword-face)
     (2 font-lock-function-name-face))

    ;; Variable declarations.
    ("\\<\\(var\\)\\s-+\\(\\w+\\)"
     (1 font-lock-keyword-face)
     (2 font-lock-variable-name-face))

    ;; Type declarations.
    ("\\<\\(type\\)\\s-+\\(\\w+\\)"
     (1 font-lock-keyword-face)
     (2 font-lock-type-face))

    ;; "var : val" type stuff (formal parameters, record fields)
    ("\\<\\(\\w+\\)\\s-*:\\s-*\\(\\w+\\)*\\>"
     (1 font-lock-variable-name-face)
     (2 font-lock-type-face))

    ;; The Tiger standard library.
    (,(concat "\\<\\(print\\|flush\\|getchar\\|ord\\|chr\\|size\\|"
              "substring\\|concat\\|not\\|exit\\)\\>")
     (1 font-lock-builtin-face)))

  "Expressions to highlight in Tiger modes.")

(defcustom tiger-mode-hook nil
  "*Hook called by `tiger-mode'."
  :type 'hook
  :group 'tiger)

(defvar tiger-mode-syntax-table nil
  "Syntax table used in Tiger mode.")

(defun tiger-mode ()
  "Major mode for editing Tiger programs.
The following keys are bound:
\\{tiger-mode-map}"
  (interactive)

  (kill-all-local-variables)
  (setq major-mode 'tiger-mode)
  (setq mode-name "Tiger")

  (setq tiger-mode-map (make-sparse-keymap))
  (use-local-map tiger-mode-map)

  (set (make-local-variable 'font-lock-defaults)
       '(tiger-font-lock-keywords nil nil))

  (setq tiger-mode-syntax-table (make-syntax-table))
  (set-syntax-table tiger-mode-syntax-table)

  ;; Tiger uses C & C++ style comments.
  (modify-syntax-entry ?/ ". 124b" tiger-mode-syntax-table)
  (modify-syntax-entry ?* ". 23" tiger-mode-syntax-table)
  (modify-syntax-entry ?\n "> b" tiger-mode-syntax-table)
  (modify-syntax-entry ?\^m "> b" tiger-mode-syntax-table)

  (run-hooks 'tiger-mode-hook))

(provide 'tiger)

;;; tiger.el ends here
