;;; -*- coding: utf-8; lexical-binding: t -*-
;;; Author: ywatanabe
;;; Timestamp: <2025-02-11 19:53:45>
;;; File: /home/ywatanabe/proj/elisp-header-footer/ehf-variables.el
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

(provide 'ehf-variables)

(when
    (not load-file-name)
  (message "ehf-variables.el loaded."
           (file-name-nondirectory
            (or load-file-name buffer-file-name))))