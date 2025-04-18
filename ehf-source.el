;;; -*- coding: utf-8; lexical-binding: t -*-
;;; Author: ywatanabe
;;; Timestamp: <2025-04-17 08:01:17>
;;; File: /home/ywatanabe/.emacs.d/lisp/emacs-header-footer/ehf-source.el

;;; Copyright (C) 2025 Yusuke Watanabe (ywatanabe@alumni.u-tokyo.ac.jp)

(require 'ehf-base)

;; Header Variables
;; ----------------------------------------

(defcustom --ehf-source-header-template
  "#!/bin/bash
# -*- coding: utf-8 -*-
# Timestamp: \"%s (%s)\"
# File: %s

THIS_DIR=\"$(cd \"$(dirname \"${BASH_SOURCE[0]}\")\" && pwd)\"
"
  "Header template for shell source files."
  :type 'string
  :group 'ehf)

(defcustom --ehf-source-header-pattern
  "\\(^#!/bin/.*sh

# -\\*- coding: utf-8 -\\*-

# Timestamp: \".* (.*)\"

# File: .*

THIS_DIR=\"\\$(cd \"\\$(dirname \"\\${BASH_SOURCE\\[0\\]}\")\" \\&\\& pwd)\"

# For removing legacy headers
# ----------------------------------------

THIS_DIR=\"\\$(cd \"\\$(dirname \"\\${BASH_SOURCE\\[0\\]}\")\" \\&\\& pwd)\"$\\)"
  "Header pattern for shell source files."
  :type 'string
  :group 'ehf)

;; Footer Variables
;; ----------------------------------------

(defcustom --ehf-source-footer-template
  "# EOF"
  "Footer template for shell source files."
  :type 'string
  :group 'ehf)

(defcustom --ehf-source-footer-pattern
  "\\(^# EOF$\\)"
  "Footer pattern for shell source files."
  :type 'string
  :group 'ehf)

;; Formatters
;; ----------------------------------------

(defun --ehf-source-format-header
    (&optional file-path)
  "Format Source header for FILE-PATH or current buffer's file."
  (let*
      ((path
        (or file-path buffer-file-name)))
    (format --ehf-source-header-template
            (format-time-string "%Y-%m-%d %H:%M:%S")
            (user-login-name)
            path)))

(defun --ehf-source-format-footer
    (&optional file-path)
  "Format Source footer for FILE-PATH or current buffer's file."
  --ehf-source-footer-template)

;; Updater
;; ----------------------------------------

(defun --ehf-source-update-header-and-footer
    (&optional file-path n-newlines)
  "Update header and footer in Source files."
  (let*
      ((path
        (or file-path buffer-file-name)))
    (--ehf-base-update-header-and-footer
     "source"
     --ehf-source-header-template
     --ehf-source-header-pattern
     #'--ehf-source-format-header
     --ehf-source-footer-template
     --ehf-source-footer-pattern
     #'--ehf-source-format-footer
     file-path
     n-newlines)))

;; ;; ;; Before Save Hook
;; ;; ;; ----------------------------------------
;; ;; (add-hook 'before-save-hook #'--ehf-source-update-header-and-footer)

(provide 'ehf-source)

(when
    (not load-file-name)
  (message "ehf-source.el loaded."
           (file-name-nondirectory
            (or load-file-name buffer-file-name))))