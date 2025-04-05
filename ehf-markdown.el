;;; -*- coding: utf-8; lexical-binding: t -*-
;;; Author: ywatanabe
;;; Timestamp: <2025-03-15 15:44:01>
;;; File: /home/ywatanabe/.emacs.d/lisp/emacs-header-footer/ehf-markdown.el

;;; Copyright (C) 2025 Yusuke Watanabe (ywatanabe@alumni.u-tokyo.ac.jp)

(require 'ehf-base)

;; Header Variables
;; ----------------------------------------

(defcustom --ehf-markdown-header-template
  "<!-- ---\n!-- Timestamp: %s\n!-- Author: %s\n!-- File: %s\n!-- --- -->\n"
  "Header template for markdown files."
  :type 'string
  :group 'ehf)

(defcustom --ehf-markdown-header-pattern
  "\\(<!-- ---\n!-- Timestamp:.*\n!-- Author:.*\n!-- File:.*\n!-- --- -->\n\\)"
  "Header pattern for markdown files."
  :type 'string
  :group 'ehf)

;; Footer Variables
;; ----------------------------------------

(defcustom --ehf-markdown-footer-template
  "<!-- EOF -->"
  "Footer template for markdown files."
  :type 'string
  :group 'ehf)

(defcustom --ehf-markdown-footer-pattern
  "\\(^<!-- EOF -->$\\)"
  "Footer pattern for markdown files."
  :type 'string
  :group 'ehf)

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