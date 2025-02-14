;;; -*- coding: utf-8; lexical-binding: t -*-
;;; Author: ywatanabe
;;; Timestamp: <2025-02-14 15:17:59>
;;; File: /home/ywatanabe/.emacs.d/lisp/emacs-header-footer/ehf-tex.el

;;; Copyright (C) 2024-2025 Yusuke Watanabe (ywatanabe@alumni.u-tokyo.ac.jp)

(require 'ehf-base)

;; Header Variables
;; ----------------------------------------

(defconst --ehf-tex-header-template
  "%%%% -*- coding: utf-8 -*-\n%%%% Timestamp: \"%s (%s)\"\n%%%% File: %s\n")

(defconst --ehf-tex-header-pattern
  "\\(%% -\\*-.*-\\*-\n%% Timestamp:.*\n%% File:.*\n$\\)")

;; Footer Variables
;; ----------------------------------------

(defconst --ehf-tex-footer-template
  "%% EOF")

(defconst --ehf-tex-footer-pattern
  "\\(^%% EOF\\)\\s-*$")

;; Formatters
;; ----------------------------------------

(defun --ehf-tex-format-header
    (file-path)
  (format --ehf-tex-header-template
          (format-time-string "%Y-%m-%d %H:%M:%S")
          (user-login-name)
          file-path))

(defun --ehf-tex-format-footer
    (&optional file-path)
  "Format TeX footer for FILE-PATH or current buffer's file."
  --ehf-tex-footer-template)

;; Updater
;; ----------------------------------------

(defun --ehf-tex-update-header-and-footer
    (&optional file-path n-newlines)
  "Update header and footer in Tex files."
  (--ehf-base-update-header-and-footer
   "tex"
   --ehf-tex-header-template
   --ehf-tex-header-pattern
   #'--ehf-tex-format-header
   --ehf-tex-footer-template
   --ehf-tex-footer-pattern
   #'--ehf-tex-format-footer
   file-path
   n-newlines))

;; ;; Before Save Hook
;; ;; ----------------------------------------
;; (add-hook 'before-save-hook #'--ehf-tex-update-header-and-footer)

(provide 'ehf-tex)

(when
    (not load-file-name)
  (message "ehf-tex.el loaded."
           (file-name-nondirectory
            (or load-file-name buffer-file-name))))