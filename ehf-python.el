;;; -*- coding: utf-8; lexical-binding: t -*-
;;; Author: ywatanabe
;;; Timestamp: <2025-02-11 19:53:44>
;;; File: /home/ywatanabe/proj/elisp-header-footer/ehf-python.el
;;; Copyright (C) 2024-2025 Yusuke Watanabe (ywatanabe@alumni.u-tokyo.ac.jp)

(require 'projectile)
(require 'ehf-base)

(defconst --ehf-python-header-template
  "#!/usr/bin/env python3\n# -*- coding: utf-8 -*-\n# Timestamp: \"%s (%s)\"\n# File: %s\n\n__file__ = \"%s\"")

(defconst --ehf-python-header-pattern
  "\\(#!.*\n# -\\*-.*-\\*-\n# Timestamp:.*\n# File:.*\n\n__file__.*$\\)")

(defconst --ehf-python-footer-template
  "# EOF")

(defconst --ehf-python-footer-pattern
  "\\(^# EOF$\\)\\s-*$")

(defun --ehf-python-format-footer
    (&optional file-path)
  "Format Python footer for FILE-PATH or current buffer's file."
  --ehf-python-footer-template)

(defun --ehf-python-format-footer
    (&optional file-path)
  "Format Python footer for FILE-PATH or current buffer's file."
  (let*
      ((path
        (or file-path buffer-file-name))
       (git-path
        (file-relative-name path
                            (projectile-project-root)))
       (src-path
        (replace-regexp-in-string "^.*?\\(src/.*\\)" "\\1" git-path))
       (module-path
        (replace-regexp-in-string
         "^[^/]*/\\(.*\\)" "\\1"
         (replace-regexp-in-string "\\.py$" "" git-path))))
    (format --ehf-python-footer-template
            src-path
            (replace-regexp-in-string "/" "."
                                      (replace-regexp-in-string "^[^/]*/" "" module-path)))))

(defun --ehf-python-insert-header
    (&optional file-path n-newlines)
  "Insert Python header for FILE-PATH or current buffer's file."
  (--ehf-base-insert-header
   --ehf-python-header-template
   #'--ehf-python-format-header
   file-path
   n-newlines))

(defun --ehf-python-insert-footer
    (&optional file-path n-newlines)
  "Insert Python footer for FILE-PATH or current buffer's file."
  (--ehf-base-insert-footer
   #'--ehf-python-format-footer
   file-path
   n-newlines))

(defun --ehf-python-remove-headers
    (&optional file-path)
  "Remove Python headers for FILE-PATH or current buffer's file."
  (--ehf-base-remove-headers
   --ehf-python-header-pattern
   "py"
   file-path))

(defun --ehf-python-remove-footers
    (&optional file-path)
  "Remove Python footers for FILE-PATH or current buffer's file."
  (--ehf-base-remove-footers
   --ehf-python-footer-pattern
   "py"
   file-path))

(defun --ehf-python-update-header
    (&optional file-path n-newlines)
  "Update header in Python FILE-PATH or current buffer's file."
  (when
      (and buffer-file-name
           (equal
            (file-name-extension buffer-file-name)
            "py"))
    (--ehf-python-remove-headers file-path)
    (--ehf-python-insert-header file-path n-newlines)))

(defun --ehf-python-update-footer
    (&optional file-path n-newlines)
  "Update footer in Python FILE-PATH or current buffer's file."
  (when
      (and buffer-file-name
           (equal
            (file-name-extension buffer-file-name)
            "py"))
    (--ehf-python-remove-footers file-path)
    (--ehf-python-insert-footer file-path n-newlines)))

;; this does not work

(defun --ehf-python-update-header-and-footer
    (&optional file-path n-newlines)
  (let
      ((n-newlines
        (or n-newlines 2)))
    (when
        (and buffer-file-name
             (equal
              (file-name-extension buffer-file-name)
              "py"))
      (--ehf-python-update-header file-path n-newlines)
      (--ehf-python-update-footer file-path n-newlines))))

;; ;; Before Save Hook
;; ;; ----------------------------------------
;; (add-hook 'before-save-hook #'--ehf-python-update-header-and-footer)

(provide 'ehf-python)

(when
    (not load-file-name)
  (message "ehf-python.el loaded."
           (file-name-nondirectory
            (or load-file-name buffer-file-name))))