

;;screensaver
(defun ctafconf-zone()
  (when (>= emacs-major-version 21)
    (require 'zone)
    (setq zone-idle 300)
    (zone-when-idle 300))
  )

