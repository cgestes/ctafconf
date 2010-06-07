;;
;; Author(s):
;;  - Cedric GESTES <ctaf42@gmail.com>
;;
;; Copyright (C) 2010 Cedric GESTES
;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3 of the License, or
;; (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program; if not, write to the Free Software
;; Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
;;

;;get the list of ctafconf profiles
(defun get-profiles (&optional file-name)
  (let (ctafconf-profiles)
    (when (file-readable-p file-name)
      (with-temp-buffer
        (insert-file-contents file-name)
        (goto-char (point-min))
        (while (re-search-forward "var_set.*ctafconf_profiles" nil t)
          (skip-chars-forward " \t\"\'")
          (let ((beg (point)))
            (forward-sentence 1)
            (skip-chars-backward " \t\"\'")
            (setq ctafconf-profiles (split-string (buffer-substring beg (point))))))))
    ctafconf-profiles))

(defun load-profiles (profiles)
  (dolist (profile ctafconf-profiles ctafconf-profiles)
    (let ((fname (concat ctafconf-path "../../profile/" profile "/profile.el")))
      (if (file-readable-p fname)
          (progn
            (message "loading ctafconf profile: %s" profile)
            (safe-load fname)
            )))
    ))

(load-profiles (get-profiles "~/.config/ctafconf/user-profile.sh"))
