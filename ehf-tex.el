;;; -*- coding: utf-8; lexical-binding: t -*-
;;; Author: ywatanabe
;;; Timestamp: <2025-03-14 14:46:52>
;;; File: /home/ywatanabe/.emacs.d/lisp/emacs-header-footer/ehf-tex.el

;;; Copyright (C) 2025 Yusuke Watanabe (ywatanabe@alumni.u-tokyo.ac.jp)

(require 'ehf-base)

;; Header Variables
;; ----------------------------------------

(defcustom --ehf-tex-header-template
  "%%%% -*- coding: utf-8 -*-\n%%%% Timestamp: \"%s (%s)\"\n%%%% File: \"%s\""
  "Header template for tex files."
  :type 'string
  :group 'ehf)

(defcustom --ehf-tex-header-pattern
  "\\(%% -\\*- coding: utf-8 -\\*-\n%% Timestamp: \".*\"\n%% File: \".*\"\\)"
  "Header pattern for tex files."
  :type 'string
  :group 'ehf)

;; Footer Variables
;; ----------------------------------------

(defcustom --ehf-tex-footer-template
  "%%%% EOF"
  "Footer template for tex files."
  :type 'string
  :group 'ehf)

(defcustom --ehf-tex-footer-pattern
  "\\(^%%%% EOF\\s-*$\\)"
  "Footer pattern for Tex files."
  :type 'string
  :group 'ehf)

;; Formatters
;; ----------------------------------------

(defun --ehf-tex-format-header
    (&optional file-path)
  "Format Tex header for FILE-PATH or current buffer's file."
  (let*
      ((path
        (or file-path buffer-file-name))
       (default-directory
        (file-name-directory path))
       (git-root
        (locate-dominating-file default-directory ".git"))
       (git-path
        (if git-root
            (file-relative-name path git-root)
          path))
       (git-path-dot
        (concat "./" git-path)))
    (format --ehf-tex-header-template
            (format-time-string "%Y-%m-%d %H:%M:%S")
            (user-login-name)
            path)))

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