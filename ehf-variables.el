;;; -*- coding: utf-8; lexical-binding: t -*-
;;; Author: ywatanabe
;;; Timestamp: <2025-02-14 15:23:47>
;;; File: /home/ywatanabe/.emacs.d/lisp/emacs-header-footer/ehf-variables.el

;;; -*- coding: utf-8; lexical-binding: t -*-
;;; Author: ywatanabe
;;; Timestamp: <2025-02-14 05:03:04>
;;; File: /home/ywatanabe/.emacs.d/lisp/emacs-header-footer/ehf-variables.el
;;; Copyright (C) 2024-2025 Yusuke Watanabe (ywatanabe@alumni.u-tokyo.ac.jp)

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

(defcustom elisp-extensions
  '("el")
  "List of Elisp file extensions."
  :type
  '(repeat string)
  :group 'ehf)

(defcustom markdown-extensions
  '("md")
  "List of Markdown file extensions."
  :type
  '(repeat string)
  :group 'ehf)

(defcustom org-extensions
  '("org")
  "List of Org file extensions."
  :type
  '(repeat string)
  :group 'ehf)

(defcustom python-extensions
  '("py")
  "List of Python file extensions."
  :type
  '(repeat string)
  :group 'ehf)

(defcustom shell-extensions
  '("sh" "bash")
  "List of Shell script file extensions."
  :type
  '(repeat string)
  :group 'ehf)

(defcustom source-extensions
  '("source" "src" "conf" "config" "def" "rc" "profile")
  "List of general source file extensions."
  :type
  '(repeat string)
  :group 'ehf)

(defcustom tex-extensions
  '("tex" "latex")
  "List of TeX file extensions."
  :type
  '(repeat string)
  :group 'ehf)

(defcustom yaml-extensions
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