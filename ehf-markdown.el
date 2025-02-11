;;; -*- coding: utf-8; lexical-binding: t -*-
;;; Author: ywatanabe
;;; Timestamp: <2025-02-11 19:53:43>
;;; File: /home/ywatanabe/proj/elisp-header-footer/ehf-markdown.el
;;; Copyright (C) 2024-2025 Yusuke Watanabe (ywatanabe@alumni.u-tokyo.ac.jp)

(require 'ehf-base)

;; Header Variables
;; ----------------------------------------
(defconst --ehf-markdown-header-template
  "<!-- ---\n!-- Timestamp: %s\n!-- Author: %s\n!-- File: %s\n!-- --- -->")

(defconst --ehf-markdown-header-pattern
  "\\(<!-- ---\n!-- Timestamp:.*\n!-- Author:.*\n!-- File:.*\n!-- --- -->\\)")

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

;; Inserters
;; ----------------------------------------
(defun --ehf-markdown-insert-header
    (&optional file-path n-newlines)
  "Insert Markdown header for FILE-PATH or current buffer's file."
  (--ehf-base-insert-header
   --ehf-markdown-header-template
   #'--ehf-markdown-format-header
   file-path
   n-newlines))

(defun --ehf-markdown-insert-footer
    (&optional file-path n-newlines)
  "Insert Markdown footer for FILE-PATH or current buffer's file."
  (--ehf-base-insert-footer
   #'--ehf-markdown-format-footer
   file-path
   n-newlines))

;; Removers
;; ----------------------------------------
(defun --ehf-markdown-remove-headers
    (&optional file-path)
  "Remove Markdown headers for FILE-PATH or current buffer's file."
  (--ehf-base-remove-headers
   --ehf-markdown-header-pattern
   "md"
   file-path))

(defun --ehf-markdown-remove-footers
    (&optional file-path)
  "Remove Markdown footers for FILE-PATH or current buffer's file."
  (--ehf-base-remove-footers
   --ehf-markdown-footer-pattern
   "md"
   file-path))

;; Updaters
;; ----------------------------------------
(defun --ehf-markdown-update-header
    (&optional file-path n-newlines)
  "Update header in Markdown FILE-PATH or current buffer's file."
  (when
      (and buffer-file-name
           (equal
            (file-name-extension buffer-file-name)
            "md"))
    (--ehf-markdown-remove-headers file-path)
    (--ehf-markdown-insert-header file-path n-newlines)))

(defun --ehf-markdown-update-footer
    (&optional file-path n-newlines)
  "Update footer in Markdown FILE-PATH or current buffer's file."
  (when
      (and buffer-file-name
           (equal
            (file-name-extension buffer-file-name)
            "md"))
    (--ehf-markdown-remove-footers file-path)
    (--ehf-markdown-insert-footer file-path n-newlines)))

(defun --ehf-markdown-update-header-and-footer
    (&optional file-path n-newlines)
  (when
      (and buffer-file-name
           (equal
            (file-name-extension buffer-file-name)
            "md"))
    (--ehf-markdown-update-header file-path n-newlines)
    (--ehf-markdown-update-footer file-path n-newlines)))

;; ;; Before Save Hook
;; ;; ----------------------------------------
;; (add-hook 'before-save-hook #'--ehf-markdown-update-header-and-footer)

(provide 'ehf-markdown)

(when
    (not load-file-name)
  (message "ehf-markdown.el loaded."
           (file-name-nondirectory
            (or load-file-name buffer-file-name))))