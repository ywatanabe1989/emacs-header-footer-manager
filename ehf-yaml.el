;;; -*- coding: utf-8; lexical-binding: t -*-
;;; Author: ywatanabe
;;; Timestamp: <2025-03-14 13:56:36>
;;; File: /home/ywatanabe/.emacs.d/lisp/emacs-header-footer/ehf-yaml.el

;;; Copyright (C) 2025 Yusuke Watanabe (ywatanabe@alumni.u-tokyo.ac.jp)

(require 'ehf-base)

;; Header Variables
;; ----------------------------------------

(defcustom --ehf-yaml-header-template
  "# Timestamp: \"%s (%s)\"\n# File: %s"
  "Header template for tex files."
  :type 'string
  :group 'ehf)

(defcustom --ehf-yaml-header-pattern
  "\\(^# Timestamp: \".* .* (.*)\"\n# File: .*$\\)"
  "Header pattern for tex files."
  :type 'string
  :group 'ehf)

;; Footer Variables
;; ----------------------------------------

(defcustom --ehf-yaml-footer-template
  "# EOF"
  "Footer template for tex files."
  :type 'string
  :group 'ehf)

(defcustom --ehf-yaml-footer-pattern
  "\\(^# EOF\\s-*$\\)"
  "Footer pattern for tex files."
  :type 'string
  :group 'ehf)

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