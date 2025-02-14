;;; -*- coding: utf-8; lexical-binding: t -*-
;;; Author: ywatanabe
;;; Timestamp: <2025-02-14 14:54:18>
;;; File: /home/ywatanabe/.emacs.d/lisp/emacs-header-footer/ehf-markdown.el

;;; -*- coding: utf-8; lexical-binding: t -*-
;;; Author: ywatanabe
;;; Timestamp: <2025-02-14 05:03:00>
;;; File: /home/ywatanabe/.emacs.d/lisp/emacs-header-footer/ehf-markdown.el
;;; Copyright (C) 2024-2025 Yusuke Watanabe (ywatanabe@alumni.u-tokyo.ac.jp)

(require 'ehf-base)

;; Header Variables
;; ----------------------------------------

(defconst --ehf-markdown-header-template
  "<!-- ---\n!-- Timestamp: %s\n!-- Author: %s\n!-- File: %s\n!-- --- -->\n")

(defconst --ehf-markdown-header-pattern
  "\\(<!-- ---\n!-- Timestamp:.*\n!-- Author:.*\n!-- File:.*\n!-- --- -->\n\\)")

;; Footer Variables
;; ----------------------------------------

(defconst --ehf-markdown-footer-template
  "<!-- EOF -->")

(defconst --ehf-markdown-footer-pattern
  "\\(<!-- EOF -->\\)\\s-*$")

;; Formatters
;; ----------------------------------------

(defun --ehf-markdown-format-header
    (&optional file-path)
  "Format Markdown header for FILE-PATH or current buffer's file."
  (let
      ((path
        (or file-path buffer-file-name)))
    (format --ehf-markdown-header-template
            (format-time-string "%Y-%m-%d %H:%M:%S")
            (user-login-name)
            path)))

(defun --ehf-markdown-format-footer
    (&optional file-path)
  "Format Markdown footer for FILE-PATH or current buffer's file."
  --ehf-markdown-footer-template)

;; Updater
;; ----------------------------------------

(defun --ehf-markdown-update-header-and-footer
    (&optional file-path n-newlines)
  "Update header and footer in Markdown files."
  (--ehf-base-update-header-and-footer
   "md"
   --ehf-markdown-header-template
   --ehf-markdown-header-pattern
   #'--ehf-markdown-format-header
   --ehf-markdown-footer-template
   --ehf-markdown-footer-pattern
   #'--ehf-markdown-format-footer
   file-path
   n-newlines))

(provide 'ehf-markdown)

(when
    (not load-file-name)
  (message "ehf-markdown.el loaded."
           (file-name-nondirectory
            (or load-file-name buffer-file-name))))