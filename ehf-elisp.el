;;; -*- coding: utf-8; lexical-binding: t -*-
;;; Author: ywatanabe
;;; Timestamp: <2025-04-24 14:30:19>
;;; File: /home/ywatanabe/.emacs.d/lisp/emacs-header-footer/ehf-elisp.el

;;; Copyright (C) 2025 Yusuke Watanabe (ywatanabe@alumni.u-tokyo.ac.jp)

(require 'ehf-base)

;; Header Variables
;; ----------------------------------------

(defcustom --ehf-elisp-header-template
  ";;; -*- coding: utf-8; lexical-binding: t -*-\n;;; Author: %s\n;;; Timestamp: <%s>\n;;; File: %s\n\n;;; Copyright (C) %s Yusuke Watanabe (ywatanabe@alumni.u-tokyo.ac.jp)"
  "Header template for Elisp files."
  :type 'string
  :group 'ehf)

(defcustom --ehf-elisp-header-pattern
  "\\(^;;; -\\*-.*

;;; -\\*- coding: utf-8; lexical-binding: t -\\*-

;;; Author: .*

;;; Timestamp: .*

;;; File: .*

;;; Copyright (C) .*$\\)"
  "Header pattern for Elisp files."
  :type 'string
  :group 'ehf)

;; Footer Variables
;; ----------------------------------------

(defcustom --ehf-elisp-footer-template
  "(provide '%s)

(when
    (not load-file-name)
  (message \"%s.el loaded.\"
           (file-name-nondirectory
            (or load-file-name buffer-file-name))))"
  "Footer template for Elisp files."
  :type 'string
  :group 'ehf)

(defcustom --ehf-elisp-footer-pattern
  "\\(^(provide '[^)]+)\\s-*

(when[[:space:]
]*(not[[:space:]
]*load-file-name)[[:space:]
]*(message[[:space:]
]*\".*\"[[:space:]
]*(file-name-nondirectory[[:space:]
]*(or[[:space:]
]*load-file-name[[:space:]
]*buffer-file-name))))$\\)"
  "Footer pattern for Elisp files."
  :type 'string
  :group 'ehf)

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
            path
            (format-time-string "%Y"))))

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

;; Updater
;; ----------------------------------------

(defun --ehf-elisp-update-header-and-footer
    (&optional file-path n-newlines)
  "Update header and footer in Elisp files."
  (let* ((this-file   "ehf-elisp.el")
         (actual-file (file-name-nondirectory
                       (or load-file-name buffer-file-name))))
    (when (not (string= actual-file this-file))
      (let ((newlines-count (or n-newlines 2)))
        (--ehf-base-update-header-and-footer
         "el"
         --ehf-elisp-header-template
         --ehf-elisp-header-pattern
         #'--ehf-elisp-format-header
         --ehf-elisp-footer-template
         --ehf-elisp-footer-pattern
         #'--ehf-elisp-format-footer
         actual-file
         newlines-count)))))

;; ;; Before Save Hook
;; ;; ----------------------------------------
;; (add-hook 'before-save-hook #'--ehf-elisp-update-header-and-footer)

(provide 'ehf-elisp)

(when
    (not load-file-name)
  (message "ehf-elisp.el loaded."
           (file-name-nondirectory
            (or load-file-name buffer-file-name))))
