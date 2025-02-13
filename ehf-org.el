;;; -*- coding: utf-8; lexical-binding: t -*-
;;; Author: ywatanabe
;;; Timestamp: <2025-02-14 05:03:01>
;;; File: /home/ywatanabe/.emacs.d/lisp/emacs-header-footer/ehf-org.el
;;; Copyright (C) 2024-2025 Yusuke Watanabe (ywatanabe@alumni.u-tokyo.ac.jp)

(require 'ehf-base)

;; Header Variables
;; ----------------------------------------

(defconst --ehf-org-header-template
  "# Timestamp: \"%s (%s)\"\n# File: %s\n\n")

(defconst --ehf-org-header-pattern
  "\\(# Timestamp:.*\n# File:.*\n\\)")

;; Footer Variables
;; ----------------------------------------

(defconst --ehf-org-footer-template
  "# EOF")

(defconst --ehf-org-footer-pattern
  "\\(# EOF\\)\\s-*$")

;; Formatters
;; ----------------------------------------

(defun --ehf-org-format-header
    (&optional file-path)
  "Format Org header for FILE-PATH or current buffer's file."
  (let
      ((path
        (or file-path buffer-file-name)))
    (format --ehf-org-header-template
            (format-time-string "%Y-%m-%d %H:%M:%S")
            (user-login-name)
            path)))

(defun --ehf-org-format-footer
    (&optional file-path)
  "Format Org footer for FILE-PATH or current buffer's file."
  --ehf-org-footer-template)

;; Updater
;; ----------------------------------------

(defun --ehf-org-update-header-and-footer
    (&optional file-path n-newlines)
  "Update header and footer in Org files."
  (--ehf-base-update-header-and-footer
   "org"
   --ehf-org-header-template
   --ehf-org-header-pattern
   #'--ehf-org-format-header
   --ehf-org-footer-template
   --ehf-org-footer-pattern
   #'--ehf-org-format-footer
   file-path
   n-newlines))

(provide 'ehf-org)

(when
    (not load-file-name)
  (message "ehf-org.el loaded."
           (file-name-nondirectory
            (or load-file-name buffer-file-name))))