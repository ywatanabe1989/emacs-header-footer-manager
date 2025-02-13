;;; -*- coding: utf-8; lexical-binding: t -*-
;;; Author: ywatanabe
;;; Timestamp: <2025-02-14 05:16:44>
;;; File: /home/ywatanabe/.emacs.d/lisp/emacs-header-footer/ehf-yaml.el
;;; Copyright (C) 2024-2025 Yusuke Watanabe (ywatanabe@alumni.u-tokyo.ac.jp)

(require 'ehf-base)

;; Header Variables
;; ----------------------------------------

(defconst --ehf-yaml-header-template
  "# Timestamp: \"%s (%s)\"\n# File: %s")

(defconst --ehf-yaml-header-pattern
  "\\(^# Timestamp: \".* .* (.*)\"\n# File: .*$\\)")

;; Footer Variables
;; ----------------------------------------

(defconst --ehf-yaml-footer-template
  "# EOF")

(defconst --ehf-yaml-footer-pattern
  "\\(^# EOF\\)\\s-*$")

;; Formatters
;; ----------------------------------------

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

;; Updater
;; ----------------------------------------

(defun --ehf-yaml-update-header-and-footer
    (&optional file-path n-newlines)
  "Update header and footer in Yaml files."
  (--ehf-base-update-header-and-footer
   "yaml"
   --ehf-yaml-header-template
   --ehf-yaml-header-pattern
   #'--ehf-yaml-format-header
   --ehf-yaml-footer-template
   --ehf-yaml-footer-pattern
   #'--ehf-yaml-format-footer
   file-path
   n-newlines))

;; ;; Before Save Hook
;; ;; ----------------------------------------
;; (add-hook 'before-save-hook #'--ehf-yaml-update-header-and-footer)

(provide 'ehf-yaml)

(when
    (not load-file-name)
  (message "ehf-yaml.el loaded."
           (file-name-nondirectory
            (or load-file-name buffer-file-name))))