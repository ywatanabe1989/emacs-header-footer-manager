;;; -*- coding: utf-8; lexical-binding: t -*-
;;; Author: ywatanabe
;;; Timestamp: <2025-02-11 19:53:42>
;;; File: /home/ywatanabe/proj/elisp-header-footer/ehf-elisp.el
;;; Copyright (C) 2024-2025 Yusuke Watanabe (ywatanabe@alumni.u-tokyo.ac.jp)

(require 'ehf-base)

;; Header Variables
;; ----------------------------------------
(defconst --ehf-elisp-header-template
  ";;; -*- coding: utf-8; lexical-binding: t -*-\n;;; Author: %s\n;;; Timestamp: <%s>\n;;; File: %s")

(defconst --ehf-elisp-header-pattern
  "\\(^;;; -\\*-.*\n;;; Author:.*\n;;; Timestamp:.*\n;;; File:.*$\\)")

;; Footer Variables
;; ----------------------------------------
(defconst --ehf-elisp-footer-template
  "(provide '%s)\n\n(when\n    (not load-file-name)\n  (message \"%s.el loaded.\"\n           (file-name-nondirectory\n            (or load-file-name buffer-file-name))))")

(defconst --ehf-elisp-footer-pattern
  "\\(^(provide '[^)]+)\\s-*\n\n(when[[:space:]\n]*(not[[:space:]\n]*load-file-name)[[:space:]\n]*(message[[:space:]\n]*\".*\"[[:space:]\n]*(file-name-nondirectory[[:space:]\n]*(or[[:space:]\n]*load-file-name[[:space:]\n]*buffer-file-name))))$\\)")

;; Formatters
;; ----------------------------------------
(defun --ehf-elisp-format-header
    (&optional file-path)
  "Format Elisp header for FILE-PATH or current buffer's file."
  (let
      ((path
        (or file-path buffer-file-name)))
    (format --ehf-elisp-header-template
            (user-login-name)
            (format-time-string "%Y-%m-%d %H:%M:%S")
            path)))

(defun --ehf-elisp-format-footer
    (&optional file-path)
  "Format Elisp footer for FILE-PATH or current buffer's file."
  (let*
      ((path
        (or file-path buffer-file-name))
       (name-without-ext
        (file-name-sans-extension
         (file-name-nondirectory path))))
    (format --ehf-elisp-footer-template
            name-without-ext
            name-without-ext)))

;; Inserters
;; ----------------------------------------
(defun --ehf-elisp-insert-header
    (&optional file-path n-newlines)
  "Insert Elisp header for FILE-PATH or current buffer's file."
  (--ehf-base-insert-header
   --ehf-elisp-header-template
   #'--ehf-elisp-format-header
   file-path
   n-newlines))

(defun --ehf-elisp-insert-footer
    (&optional file-path n-newlines)
  "Insert Elisp footer for FILE-PATH or current buffer's file."
  (--ehf-base-insert-footer
   #'--ehf-elisp-format-footer
   file-path
   n-newlines))

;; Removers
;; ----------------------------------------
(defun --ehf-elisp-remove-headers
    (&optional file-path)
  "Remove Elisp headers for FILE-PATH or current buffer's file."
  (--ehf-base-remove-headers
   --ehf-elisp-header-pattern
   "el"
   file-path))

(defun --ehf-elisp-remove-footers
    (&optional file-path)
  "Remove Elisp footers for FILE-PATH or current buffer's file."
  (--ehf-base-remove-footers
   --ehf-elisp-footer-pattern
   "el"
   file-path))

;; Updaters
;; ----------------------------------------
(defun --ehf-elisp-update-header
    (&optional file-path n-newlines)
  "Update header in Elisp FILE-PATH or current buffer's file."
  (when
      (and buffer-file-name
           (equal
            (file-name-extension buffer-file-name)
            "el"))
    (--ehf-elisp-remove-headers file-path)
    (--ehf-elisp-insert-header file-path n-newlines)))

(defun --ehf-elisp-update-footer
    (&optional file-path n-newlines)
  "Update footer in Elisp FILE-PATH or current buffer's file."
  (when
      (and buffer-file-name
           (equal
            (file-name-extension buffer-file-name)
            "el"))
    (--ehf-elisp-remove-footers file-path)
    (--ehf-elisp-insert-footer file-path n-newlines)))

(defun --ehf-elisp-update-header-and-footer
    (&optional file-path n-newlines)
  (when
      (and buffer-file-name
           (equal
            (file-name-extension buffer-file-name)
            "el"))
    (--ehf-elisp-update-header file-path n-newlines)
    (--ehf-elisp-update-footer file-path n-newlines)))

;; ;; Before Save Hook
;; ;; ----------------------------------------
;; (add-hook 'before-save-hook #'--ehf-elisp-update-header-and-footer)

(provide 'ehf-elisp)

(when
    (not load-file-name)
  (message "ehf-elisp.el loaded."
           (file-name-nondirectory
            (or load-file-name buffer-file-name))))