;;; -*- coding: utf-8; lexical-binding: t -*-
;;; Author: ywatanabe
;;; Timestamp: <2025-02-11 19:53:44>
;;; File: /home/ywatanabe/proj/elisp-header-footer/ehf-yaml.el
;;; Copyright (C) 2024-2025 Yusuke Watanabe (ywatanabe@alumni.u-tokyo.ac.jp)

(require 'ehf-base)

(defconst --ehf-yaml-header-template
  "# Timestamp: \"%s (%s)\"\n# File: %s")

(defconst --ehf-yaml-header-pattern
  "\\(# Timestamp:.*\n# File:.*$\\)")

(defconst --ehf-yaml-footer-template
  "# EOF")

(defconst --ehf-yaml-footer-pattern
  "\\(# EOF\\)\\s-*$")

(defun --ehf-yaml-format-header
    (&optional file-path)
  "Format YAML header for FILE-PATH or current buffer's file."
  (let
      ((path
        (or file-path buffer-file-name)))
    (format --ehf-yaml-header-template
            (format-time-string "%Y-%m-%d %H:%M:%S")
            (user-login-name)
            path)))

(defun --ehf-yaml-format-footer
    (&optional file-path)
  "Format YAML footer for FILE-PATH or current buffer's file."
  --ehf-yaml-footer-template)

(defun --ehf-yaml-insert-header
    (&optional file-path n-newlines)
  "Insert YAML header for FILE-PATH or current buffer's file."
  (--ehf-base-insert-header
   --ehf-yaml-header-template
   #'--ehf-yaml-format-header
   file-path
   n-newlines))

(defun --ehf-yaml-insert-footer
    (&optional file-path n-newlines)
  "Insert YAML footer for FILE-PATH or current buffer's file."
  (--ehf-base-insert-footer
   #'--ehf-yaml-format-footer
   file-path
   n-newlines))

(defun --ehf-yaml-remove-headers
    (&optional file-path)
  "Remove YAML headers for FILE-PATH or current buffer's file."
  (--ehf-base-remove-headers
   --ehf-yaml-header-pattern
   "yaml"
   file-path))

(defun --ehf-yaml-remove-footers
    (&optional file-path)
  "Remove YAML footers for FILE-PATH or current buffer's file."
  (--ehf-base-remove-footers
   --ehf-yaml-footer-pattern
   "yaml"
   file-path))

(defun --ehf-yaml-update-header
    (&optional file-path n-newlines)
  "Update header in YAML FILE-PATH or current buffer's file."
  (when
      (and buffer-file-name
           (or
            (equal
             (file-name-extension buffer-file-name)
             "yaml")
            (equal
             (file-name-extension buffer-file-name)
             "yml")))
    (--ehf-yaml-remove-headers file-path)
    (--ehf-yaml-insert-header file-path n-newlines)))

(defun --ehf-yaml-update-footer
    (&optional file-path n-newlines)
  "Update footer in YAML FILE-PATH or current buffer's file."
  (when
      (and buffer-file-name
           (or
            (equal
             (file-name-extension buffer-file-name)
             "yaml")
            (equal
             (file-name-extension buffer-file-name)
             "yml")))
    (--ehf-yaml-remove-footers file-path)
    (--ehf-yaml-insert-footer file-path n-newlines)))

(defun --ehf-yaml-update-header-and-footer
    (&optional file-path n-newlines)
  (when
      (and buffer-file-name
           (or
            (equal
             (file-name-extension buffer-file-name)
             "yaml")
            (equal
             (file-name-extension buffer-file-name)
             "yml")))
    (--ehf-yaml-update-header file-path n-newlines)
    (--ehf-yaml-update-footer file-path n-newlines)))

;; ;; Before Save Hook
;; ;; ----------------------------------------
;; (add-hook 'before-save-hook #'--ehf-yaml-update-header-and-footer)

(provide 'ehf-yaml)

(when
    (not load-file-name)
  (message "ehf-yaml.el loaded."
           (file-name-nondirectory
            (or load-file-name buffer-file-name))))