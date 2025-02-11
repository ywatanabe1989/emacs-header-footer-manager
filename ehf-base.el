;;; -*- coding: utf-8; lexical-binding: t -*-
;;; Author: ywatanabe
;;; Timestamp: <2025-02-11 19:52:14>
;;; File: /home/ywatanabe/proj/elisp-header-footer/ehf-base.el
;;; Copyright (C) 2025 Yusuke Watanabe (ywatanabe@alumni.u-tokyo.ac.jp)

;; Base functions
;; ----------------------------------------
(defun --ehf-base-insert-header
    (template format-fn file-path n-newlines)
  "Generic function to insert header using TEMPLATE and FORMAT-FN."
  (let*
      ((path
        (or file-path buffer-file-name))
       (n-newlines
        (or n-newlines 1))
       (formatted-header
        (funcall format-fn path)))
    (save-excursion
      (goto-char
       (point-min))
      (insert formatted-header)
      (insert
       (make-string n-newlines ?\n)))))

(defun --ehf-base-insert-footer
    (format-fn file-path n-newlines)
  "Generic function to insert footer using FORMAT-FN."
  (let
      ((path
        (or file-path buffer-file-name))
       (n-newlines
        (or n-newlines 1)))
    (save-excursion
      (goto-char
       (point-max))
      (delete-blank-lines)
      (insert
       (make-string n-newlines ?\n))
      (insert
       (funcall format-fn path)))))

(defun --ehf-base-remove-headers
    (pattern extension file-path)
  "Generic function to remove headers using PATTERN for files with EXTENSION."
  (let
      ((path
        (or file-path buffer-file-name)))
    (when
        (equal
         (file-name-extension path)
         extension)
      (save-excursion
        (goto-char
         (point-min))
        (while
            (not
             (eobp))
          (when
              (looking-at pattern)
            (delete-region
             (match-beginning 0)
             (match-end 0))
            (delete-blank-lines))
          (forward-line))))))

(defun --ehf-base-remove-footers
    (pattern extension file-path)
  "Generic function to remove footers using PATTERN for files with EXTENSION."
  (let
      ((path
        (or file-path buffer-file-name)))
    (when
        (equal
         (file-name-extension path)
         extension)
      (save-excursion
        (goto-char
         (point-max))
        (while
            (re-search-backward pattern nil t)
          (delete-region
           (match-beginning 0)
           (match-end 0))
          (goto-char
           (point-max)))))))

(provide 'ehf-base)

(when
    (not load-file-name)
  (message "ehf-base.el loaded."
           (file-name-nondirectory
            (or load-file-name buffer-file-name))))