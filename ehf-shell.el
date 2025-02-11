;;; -*- coding: utf-8; lexical-binding: t -*-
;;; Author: ywatanabe
;;; Timestamp: <2025-02-11 19:53:42>
;;; File: /home/ywatanabe/proj/elisp-header-footer/ehf-shell.el
;;; Copyright (C) 2024-2025 Yusuke Watanabe (ywatanabe@alumni.u-tokyo.ac.jp)

(require 'ehf-base)

;; Header Variables
;; ----------------------------------------
(defconst --ehf-shell-header-template
  "#!/bin/bash\n# -*- coding: utf-8 -*-\n# Timestamp: \"%s (%s)\"\n# File: %s\n\nTHIS_DIR=\"$(cd \"$(dirname \"${BASH_SOURCE[0]}\")\" && pwd)\"\nLOG_PATH=\"$0.log\"\ntouch \"$LOG_PATH\"")

(defconst --ehf-shell-header-pattern
  "\\(^#!/bin/bash\n# -\\*- coding: utf-8 -\\*-\n# Timestamp: \".* (.*)\"\n# File: .*\n\nTHIS_DIR=\"\\$(cd \"\\$(dirname \"\\${BASH_SOURCE\\[0\\]}\")\" \\&\\& pwd)\"\nLOG_PATH=\"\\$0.log\"\ntouch \"\\$LOG_PATH\"$\\)")

;; Footer Variables
;; ----------------------------------------
(defconst --ehf-shell-footer-template
  "# EOF")

(defconst --ehf-shell-footer-pattern
  "\\(^# EOF$\\)")

(defun --ehf-shell-format-header
    (&optional file-path)
  "Format Shell header for FILE-PATH or current buffer's file."
  (let
      ((path
        (or file-path buffer-file-name)))
    (format --ehf-shell-header-template
            (format-time-string "%Y-%m-%d %H:%M:%S")
            (user-login-name)
            path)))

(defun --ehf-shell-format-footer
    (&optional file-path)
  "Format Shell footer for FILE-PATH or current buffer's file."
  --ehf-shell-footer-template)

(defun --ehf-shell-insert-header
    (&optional file-path n-newlines)
  "Insert Shell header for FILE-PATH or current buffer's file."
  (--ehf-base-insert-header
   --ehf-shell-header-template
   #'--ehf-shell-format-header
   file-path
   n-newlines))

(defun --ehf-shell-insert-footer
    (&optional file-path n-newlines)
  "Insert Shell footer for FILE-PATH or current buffer's file."
  (--ehf-base-insert-footer
   #'--ehf-shell-format-footer
   file-path
   n-newlines))

(defun --ehf-shell-remove-headers
    (&optional file-path)
  "Remove Shell headers for FILE-PATH or current buffer's file."
  (--ehf-base-remove-headers
   --ehf-shell-header-pattern
   "sh"
   file-path))

(defun --ehf-shell-remove-footers
    (&optional file-path)
  "Remove Shell footers for FILE-PATH or current buffer's file."
  (--ehf-base-remove-footers
   --ehf-shell-footer-pattern
   "sh"
   file-path))

(defun --ehf-shell-update-header
    (&optional file-path n-newlines)
  "Update header in Shell FILE-PATH or current buffer's file."
  (when
      (and buffer-file-name
           (equal
            (file-name-extension buffer-file-name)
            "sh"))
    (--ehf-shell-remove-headers file-path)
    (--ehf-shell-insert-header file-path n-newlines)))

(defun --ehf-shell-update-footer
    (&optional file-path n-newlines)
  "Update footer in Shell FILE-PATH or current buffer's file."
  (when
      (and buffer-file-name
           (equal
            (file-name-extension buffer-file-name)
            "sh"))
    (--ehf-shell-remove-footers file-path)
    (--ehf-shell-insert-footer file-path n-newlines)))

(defun --ehf-shell-update-header-and-footer
    (&optional file-path n-newlines)
  (let
      ((n-newlines
        (or n-newlines 2)))
    (when
        (and buffer-file-name
             (equal
              (file-name-extension buffer-file-name)
              "sh"))
      (--ehf-shell-update-header file-path n-newlines)
      (--ehf-shell-update-footer file-path n-newlines))))

;; ;; Before Save Hook
;; ;; ----------------------------------------
;; (add-hook 'before-save-hook #'--ehf-shell-update-header-and-footer)

(provide 'ehf-shell)

(when
    (not load-file-name)
  (message "ehf-shell.el loaded."
           (file-name-nondirectory
            (or load-file-name buffer-file-name))))