;;; -*- coding: utf-8; lexical-binding: t -*-
;;; Author: ywatanabe
;;; Timestamp: <2025-02-11 23:33:17>
;;; File: /home/ywatanabe/.dotfiles/.emacs.d/lisp/emacs-header-footer/ehf-tex.el
;;; Copyright (C) 2024-2025 Yusuke Watanabe (ywatanabe@alumni.u-tokyo.ac.jp)

(require 'ehf-base)

(defconst --ehf-tex-header-pattern
  "\\(%% -\\*-.*-\\*-\n%% Timestamp:.*\n%% File:.*$\\)")

(defconst --ehf-tex-footer-template
  "%% EOF")

(defconst --ehf-tex-footer-pattern
  "\\(^%% EOF\\)\\s-*$")

(defconst --ehf-tex-header-template
  "%%%% -*- coding: utf-8 -*-\n%%%% Timestamp: \"%s (%s)\"\n%%%% File: %s")

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

(defun --ehf-tex-insert-header
    (&optional file-path n-newlines)
  "Insert TeX header for FILE-PATH or current buffer's file."
  (--ehf-base-insert-header
   --ehf-tex-header-template
   #'--ehf-tex-format-header
   file-path
   n-newlines))

(defun --ehf-tex-insert-footer
    (&optional file-path n-newlines)
  "Insert TeX footer for FILE-PATH or current buffer's file."
  (--ehf-base-insert-footer
   #'--ehf-tex-format-footer
   file-path
   n-newlines))

(defun --ehf-tex-remove-headers
    (&optional file-path)
  "Remove TeX headers for FILE-PATH or current buffer's file."
  (--ehf-base-remove-headers
   --ehf-tex-header-pattern
   "tex"
   file-path))

(defun --ehf-tex-remove-footers
    (&optional file-path)
  "Remove TeX footers for FILE-PATH or current buffer's file."
  (--ehf-base-remove-footers
   --ehf-tex-footer-pattern
   "tex"
   file-path))

(defun --ehf-tex-update-header
    (&optional file-path n-newlines)
  "Update header in TeX FILE-PATH or current buffer's file."
  (when
      (and buffer-file-name
           (equal
            (file-name-extension buffer-file-name)
            "tex"))
    (--ehf-tex-remove-headers file-path)
    (--ehf-tex-insert-header file-path n-newlines)))

(defun --ehf-tex-update-footer
    (&optional file-path n-newlines)
  "Update footer in TeX FILE-PATH or current buffer's file."
  (when
      (and buffer-file-name
           (equal
            (file-name-extension buffer-file-name)
            "tex"))
    (--ehf-tex-remove-footers file-path)
    (--ehf-tex-insert-footer file-path n-newlines)))

(defun --ehf-tex-update-header-and-footer
    (&optional file-path n-newlines)
  (when
      (and buffer-file-name
           (equal
            (file-name-extension buffer-file-name)
            "tex"))
    (--ehf-tex-update-header file-path n-newlines)
    (--ehf-tex-update-footer file-path n-newlines)))

;; ;; Before Save Hook
;; ;; ----------------------------------------
;; (add-hook 'before-save-hook #'--ehf-tex-update-header-and-footer)

(provide 'ehf-tex)

(when
    (not load-file-name)
  (message "ehf-tex.el loaded."
           (file-name-nondirectory
            (or load-file-name buffer-file-name))))