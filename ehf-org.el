;;; -*- coding: utf-8; lexical-binding: t -*-
;;; Author: ywatanabe
;;; Timestamp: <2025-02-11 19:53:45>
;;; File: /home/ywatanabe/proj/elisp-header-footer/ehf-org.el
;;; Copyright (C) 2024-2025 Yusuke Watanabe (ywatanabe@alumni.u-tokyo.ac.jp)

(require 'ehf-base)

(defconst --ehf-org-header-template
  "# Timestamp: \"%s (%s)\"\n# File: %s\n\n")

(defconst --ehf-org-header-pattern
  "\\(# Timestamp:.*\n# File:.*\n\\)")

(defconst --ehf-org-footer-template
  "# EOF")

(defconst --ehf-org-footer-pattern
  "\\(# EOF\\)\\s-*$")

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

(defun --ehf-org-insert-header
    (&optional file-path n-newlines)
  "Insert Org header for FILE-PATH or current buffer's file."
  (--ehf-base-insert-header
   --ehf-org-header-template
   #'--ehf-org-format-header
   file-path
   n-newlines))

(defun --ehf-org-insert-footer
    (&optional file-path n-newlines)
  "Insert Org footer for FILE-PATH or current buffer's file."
  (--ehf-base-insert-footer
   #'--ehf-org-format-footer
   file-path
   n-newlines))

(defun --ehf-org-remove-headers
    (&optional file-path)
  "Remove Org headers for FILE-PATH or current buffer's file."
  (--ehf-base-remove-headers
   --ehf-org-header-pattern
   "org"
   file-path))

(defun --ehf-org-remove-footers
    (&optional file-path)
  "Remove Org footers for FILE-PATH or current buffer's file."
  (--ehf-base-remove-footers
   --ehf-org-footer-pattern
   "org"
   file-path))

(defun --ehf-org-update-header
    (&optional file-path n-newlines)
  "Update header in Org FILE-PATH or current buffer's file."
  (when
      (and buffer-file-name
           (equal
            (file-name-extension buffer-file-name)
            "org"))
    (--ehf-org-remove-headers file-path)
    (--ehf-org-insert-header file-path n-newlines)))

(defun --ehf-org-update-footer
    (&optional file-path n-newlines)
  "Update footer in Org FILE-PATH or current buffer's file."
  (when
      (and buffer-file-name
           (equal
            (file-name-extension buffer-file-name)
            "org"))
    (--ehf-org-remove-footers file-path)
    (--ehf-org-insert-footer file-path n-newlines)))

(defun --ehf-org-update-header-and-footer
    (&optional file-path n-newlines)
  (when
      (and buffer-file-name
           (equal
            (file-name-extension buffer-file-name)
            "org"))
    (--ehf-org-update-header file-path n-newlines)
    (--ehf-org-update-footer file-path n-newlines)))

;; ;; Before Save Hook
;; ;; ----------------------------------------
;; (add-hook 'before-save-hook #'--ehf-org-update-header-and-footer)

(provide 'ehf-org)

(when
    (not load-file-name)
  (message "ehf-org.el loaded."
           (file-name-nondirectory
            (or load-file-name buffer-file-name))))