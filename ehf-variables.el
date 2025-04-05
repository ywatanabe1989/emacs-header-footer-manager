;;; -*- coding: utf-8; lexical-binding: t -*-
;;; Author: ywatanabe
;;; Timestamp: <2025-03-14 18:28:11>
;;; File: /home/ywatanabe/.emacs.d/lisp/emacs-header-footer/ehf-variables.el

;;; Copyright (C) 2025 Yusuke Watanabe (ywatanabe@alumni.u-tokyo.ac.jp)

;; Customization Group
;; ----------------------------------------

(defgroup ehf nil
  "Automatic header and footer management."
  :prefix "ehf-"
  :group 'convenience)

(defcustom ehf-exclude-files
  '()
  "List of files to exclude from header/footer updates."
  :type
  '(repeat string)
  :group 'ehf)

;; Definitions
;; ----------------------------------------

(defcustom ehf-elisp-extensions
  '("el")
  "List of Elisp file extensions."
  :type
  '(repeat string)
  :group 'ehf)

(defcustom ehf-markdown-extensions
  '("md")
  "List of Markdown file extensions."
  :type
  '(repeat string)
  :group 'ehf)

(defcustom ehf-org-extensions
  '("org")
  "List of Org file extensions."
  :type
  '(repeat string)
  :group 'ehf)

(defcustom ehf-python-extensions
  '("py")
  "List of Python file extensions."
  :type
  '(repeat string)
  :group 'ehf)

(defcustom ehf-shell-extensions
  '("sh" "bash")
  "List of Shell script file extensions."
  :type
  '(repeat string)
  :group 'ehf)

(defcustom ehf-source-extensions
  '("src")
  "List of general source file extensions."
  :type
  '(repeat string)
  :group 'ehf)

(defcustom ehf-tex-extensions
  '("tex" "latex")
  "List of TeX file extensions."
  :type
  '(repeat string)
  :group 'ehf)

(defcustom ehf-yaml-extensions
  '("yaml" "yml")
  "List of YAML file extensions."
  :type
  '(repeat string)
  :group 'ehf)

(provide 'ehf-variables)

(when
    (not load-file-name)
  (message "ehf-variables.el loaded."
           (file-name-nondirectory
            (or load-file-name buffer-file-name))))