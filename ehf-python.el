;;; -*- coding: utf-8; lexical-binding: t -*-
;;; Author: ywatanabe
;;; Timestamp: <2025-04-23 05:39:32>
;;; File: /home/ywatanabe/.emacs.d/lisp/emacs-header-footer/ehf-python.el

;;; Copyright (C) 2025 Yusuke Watanabe (ywatanabe@alumni.u-tokyo.ac.jp)

(require 'projectile)
(require 'ehf-base)

;; Header Variables
;; ----------------------------------------

;; (defcustom --ehf-python-header-template
;;   "#!/usr/bin/env python3\n# -*- coding: utf-8 -*-\n# Timestamp: \"%s (%s)\"\n# File: %s\n\nimport os\n\n__FILE__ = (\n    \"%s\"\n)\n\n__DIR__ = os.path.dirname(__FILE__)"
;;   "Header template for Python files."
;;   :type 'string
;;   :group 'ehf)

;; (defcustom --ehf-python-header-pattern
;;   "\\(^#!/usr/bin/env python3\n# -\\*- coding: utf-8 -\\*-\n# Timestamp: \".* (.*)\"\n# File: .*\n\nimport os\n\n__FILE__ = (\n    \".*\"\n)\n\n__DIR__ = os.path.dirname(__FILE__)\n\n__FILE__ = \".*\"\n\n__DIR__ = os.path.dirname(__FILE__)$\\)"
;;   "Header pattern for Python files."
;;   :type 'string
;;   :group 'ehf)

(defcustom --ehf-python-header-template
  "#!/usr/bin/env python3\n# -*- coding: utf-8 -*-
# Timestamp: \"%s (%s)\"
# File: %s
# ----------------------------------------
import os
__FILE__ = (
    \"%s\"
)
__DIR__ = os.path.dirname(__FILE__)
# ----------------------------------------"
  "Header template for Python files."
  :type 'string
  :group 'ehf)

(defcustom --ehf-python-header-pattern
  "\\(^#!/usr/bin/env python3
# -\\*- coding: utf-8 -\\*-
# Timestamp: \".* (.*)\"
# File: .*

import os

__FILE__ = (
    \".*\"
)

__DIR__ = os.path.dirname(__FILE__)

__FILE__ = \".*\"

# ----------------------------------------$\\)"
  "Header pattern for Python files."
  :type 'string
  :group 'ehf)

;; Footer Variables
;; ----------------------------------------

(defcustom --ehf-python-footer-template
  "# EOF"
  "Footer template for Python files."
  :type 'string
  :group 'ehf)

(defcustom --ehf-python-footer-pattern
  "\\(^# EOF$\\)"
  "Footer pattern for Python files."
  :type 'string
  :group 'ehf)

;; Formatters
;; ----------------------------------------

(defun --ehf-python-format-header
    (&optional file-path)
  "Format Python header for FILE-PATH or current buffer's file."
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
    (format --ehf-python-header-template
            (format-time-string "%Y-%m-%d %H:%M:%S")
            (user-login-name)
            path
            git-path-dot)))
;; path)))
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
                                      (replace-regexp-in-string
                                       "^[^/]*/" "" module-path)))))

;; Updater
;; ----------------------------------------

(defun --ehf-python-update-header-and-footer
    (&optional file-path n-newlines)
  "Update header and footer in Python files."
  (--ehf-base-update-header-and-footer
   "py"
   --ehf-python-header-template
   --ehf-python-header-pattern
   #'--ehf-python-format-header
   --ehf-python-footer-template
   --ehf-python-footer-pattern
   #'--ehf-python-format-footer
   file-path
   n-newlines))

(provide 'ehf-python)

(when
    (not load-file-name)
  (message "ehf-python.el loaded."
           (file-name-nondirectory
            (or load-file-name buffer-file-name))))