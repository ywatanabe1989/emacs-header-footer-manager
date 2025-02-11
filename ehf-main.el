;;; -*- coding: utf-8; lexical-binding: t -*-
;;; Author: ywatanabe
;;; Timestamp: <2025-02-11 19:53:42>
;;; File: /home/ywatanabe/proj/elisp-header-footer/ehf-main.el
;;; Copyright (C) 2024-2025 Yusuke Watanabe (ywatanabe@alumni.u-tokyo.ac.jp)

;; Main Function
;; ----------------------------------------

(defun ehf-update-header-and-footer
    (&optional file-path n-newlines)
  "Update header and footer for current buffer or FILE-PATH with N-NEWLINES spacing.
If the file is in `ehf-exclude-files`, it will be skipped."
  (interactive)
  (when
      (and buffer-file-name
           (not
            (member
             (expand-file-name buffer-file-name)
             ehf-exclude-files)))
    (let
        ((ext
          (file-name-extension buffer-file-name)))
      (cond
       ((equal ext "el")
        (--ehf-elisp-update-header-and-footer file-path n-newlines))
       ((equal ext "md")
        (--ehf-markdown-update-header-and-footer file-path n-newlines))
       ((equal ext "org")
        (--ehf-org-update-header-and-footer file-path n-newlines))
       ((equal ext "py")
        (--ehf-python-update-header-and-footer file-path n-newlines))
       ((equal ext "sh")
        (--ehf-shell-update-header-and-footer file-path n-newlines))
       ((equal ext "tex")
        (--ehf-tex-update-header-and-footer file-path n-newlines))
       ((or
         (equal ext "yaml")
         (equal ext "yml"))
        (--ehf-yaml-update-header-and-footer file-path n-newlines))))))

;; ;; Before Save Hook
;; ;; ----------------------------------------
;; (add-hook 'before-save-hook #'ehf-update-header-and-footer)

(provide 'ehf-main)

(when
    (not load-file-name)
  (message "ehf-main.el loaded."
           (file-name-nondirectory
            (or load-file-name buffer-file-name))))