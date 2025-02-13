;;; -*- coding: utf-8; lexical-binding: t -*-
;;; Author: ywatanabe
;;; Timestamp: <2025-02-14 05:03:02>
;;; File: /home/ywatanabe/.emacs.d/lisp/emacs-header-footer/ehf-shell.el
;;; Copyright (C) 2024-2025 Yusuke Watanabe (ywatanabe@alumni.u-tokyo.ac.jp)

(require 'ehf-base)

;; Header Variables
;; ----------------------------------------

(defconst --ehf-shell-header-templates
  '(("zsh" . "#!/bin/zsh\n# -*- coding: utf-8 -*-\n# Timestamp: \"%s (%s)\"\n# File: %s\n\nTHIS_DIR=\"${0:A:h}\"\nLOG_PATH=\"$0.log\"\ntouch \"$LOG_PATH\"")
    ("fish" . "#!/usr/bin/env fish\n# -*- coding: utf-8 -*-\n# Timestamp: \"%s (%s)\"\n# File: %s\n\nset THIS_DIR (dirname (status filename))\nset LOG_PATH \"$argv[1].log\"\ntouch \"$LOG_PATH\"")
    ("ksh" . "#!/bin/ksh\n# -*- coding: utf-8 -*-\n# Timestamp: \"%s (%s)\"\n# File: %s\n\nTHIS_DIR=$(cd \"$(dirname \"${0}\")\" && pwd)\nLOG_PATH=\"$0.log\"\ntouch \"$LOG_PATH\"")
    ("t" . "#!/bin/bash\n# -*- coding: utf-8 -*-\n# Timestamp: \"%s (%s)\"\n# File: %s\n\nTHIS_DIR=\"$(cd \"$(dirname \"${BASH_SOURCE[0]}\")\" && pwd)\"\nLOG_PATH=\"$0.log\"\ntouch \"$LOG_PATH\"")))

(defconst --ehf-shell-header-pattern
  "\\(^#!/bin/.*sh\n# -\\*- coding: utf-8 -\\*-\n# Timestamp: \".* (.*)\"\n# File: .*\n\nTHIS_DIR=\"\\$(cd \"\\$(dirname \"\\${BASH_SOURCE\\[0\\]}\")\" \\&\\& pwd)\"\nLOG_PATH=\"\\$0.log\"\ntouch \"\\$LOG_PATH\"$\\)")

;; Footer Variables
;; ----------------------------------------

(defconst --ehf-shell-footer-template
  "# EOF")

(defconst --ehf-shell-footer-pattern
  "\\(^# EOF$\\)")

;; Formatters
;; ----------------------------------------

(defun --ehf-shell-format-header
    (&optional file-path)
  "Format Shell header for FILE-PATH or current buffer's file."
  (let*
      ((path
        (or file-path buffer-file-name))
       (shell-type
        (--ehf-shell-get-shell-type path))
       (template
        (cdr
         (assoc shell-type --ehf-shell-header-templates))))
    (format template
            (format-time-string "%Y-%m-%d %H:%M:%S")
            (user-login-name)
            path)))

(defun --ehf-shell-format-footer
    (&optional file-path)
  "Format Shell footer for FILE-PATH or current buffer's file."
  --ehf-shell-footer-template)

(defun --ehf-shell-get-shell-type
    (file-path)
  "Get shell type from FILE-PATH extension."
  (let
      ((ext
        (file-name-extension file-path)))
    (cond
     ((equal ext "zsh")
      "zsh")
     ((equal ext "fish")
      "fish")
     ((equal ext "ksh")
      "ksh")
     (t "t"))))

;; Updater
;; ----------------------------------------

(defun --ehf-shell-update-header-and-footer
    (&optional file-path n-newlines)
  "Update header and footer in Shell files."
  (let*
      ((path
        (or file-path buffer-file-name))
       (shell-type
        (--ehf-shell-get-shell-type path))
       (header-template
        (cdr
         (assoc shell-type --ehf-shell-header-templates))))
    (--ehf-base-update-header-and-footer
     "sh"
     header-template
     --ehf-shell-header-pattern
     #'--ehf-shell-format-header
     --ehf-shell-footer-template
     --ehf-shell-footer-pattern
     #'--ehf-shell-format-footer
     file-path
     n-newlines)))

;; ;; ;; Before Save Hook
;; ;; ;; ----------------------------------------
;; ;; (add-hook 'before-save-hook #'--ehf-shell-update-header-and-footer)

(provide 'ehf-shell)

(when
    (not load-file-name)
  (message "ehf-shell.el loaded."
           (file-name-nondirectory
            (or load-file-name buffer-file-name))))