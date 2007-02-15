;;
;; menu.emacs for ctafconf in /home/ctaf/.ctafconf/etc/emacs/site-lisp
;;
;; Made by GESTES Cedric
;; Login   <ctaf@epita.fr>
;;
;; Started on  Mon Jan 16 05:39:19 2006 GESTES Cedric
;; Last update Thu Feb 15 18:56:00 2007 GESTES Cedric
;;

;;
;;CTAFCONF
;;  display the help
;;  edit your personnal setting
;;  load ilisp
;;  load cedet
;;  load ecb
;;PROG
;;  add doxymacs headers
;;  add doxymacs function headers
;;  htmlize buffer

;; (require 'menu-bar)
(message ".")
(message "ctafconf loading: SETTINGS.EMACS")

;; ;; organized buffer menu
(msb-mode 1)

(condition-case err
    (progn
      (require 'easymenu)
      (interactive)
      (easy-menu-add-item nil nil '("CtafConf"))
      (easy-menu-add-item nil '("CtafConf")
                          '("Load component"
                            ["Zone Screensaver" (ctafconf-zone) t]
                            ["Ilisp" (ctafconf-ilisp) t]
                            ["Cedet" (ctafconf-cedet) t]
                            ["ECB" (ctafconf-ecb) t]
                            ))

      (easy-menu-add-item nil '("CtafConf")
                          '("Prog"
                            ["Add doxygen file comment" (doxymacs-insert-file-comment) t]
                            ["Add doxygen function comment" (doxymacs-insert-function-comment) t]
                            ["Add doxygen member header" (doxymacs-insert-member-comment) t]
                            "-"
;;                            ["htmlize buffer" my-function t]
                            ))

      (easy-menu-add-item nil '("CtafConf")
                          '("Misc"
                            ["Resize emacs to 80x25" (ctafconf-resize-80x25) t]
                            ))
      (easy-menu-add-item nil '("CtafConf") '("-"))
      (easy-menu-add-item nil '("CtafConf")
                          '["CtafConf help" (lambda ()
                                               (interactive)
                                               (switch-to-buffer "*scratch*")
                                               (ctafconf-help))]
                                               )

      )
  (error
   (message "Cannot load easymenu %s" (cdr err))))
