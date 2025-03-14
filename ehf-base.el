;;; -*- coding: utf-8; lexical-binding: t -*-
;;; Author: ywatanabe
;;; Timestamp: <2025-03-14 14:31:11>
;;; File: /home/ywatanabe/.emacs.d/lisp/emacs-header-footer/ehf-base.el

;;; Copyright (C) 2025 Yusuke Watanabe (ywatanabe@alumni.u-tokyo.ac.jp)

(require 'ehf-route-ext)

;; Empty Line Handling
;; ----------------------------------------

(defun --ehf-base-ensure-replacesable-pattern
    (pattern)
  "Ensure pattern is in replaceable format: \\(^PATTERN_HERE$\\)."
  (let* ((is-start-valid (string-match-p "^\\\\(\\^" pattern))
         (is-end-valid (string-match-p "\\$\\\\)$" pattern))
         (trimmed-pattern (string-trim pattern))
         (result (cond
                  ((and (not is-start-valid) (not is-end-valid))
                   (concat "\\(^" trimmed-pattern "$\\)"))
                  ((not is-start-valid)
                   (concat "\\(^" trimmed-pattern))
                  ((not is-end-valid)
                   (concat trimmed-pattern "$\\)"))
                  (t pattern))))
    result))

(defun --ehf-base-split-pattern-at-empty-line
    (pattern)
  "Split PATTERN at empty lines into a list of chunks recursively."
  (if (string-match "\n\n" pattern)
      (let ((before (substring pattern 0 (match-beginning 0)))
            (after (substring pattern (match-end 0))))
        (append
         (list (--ehf-base-ensure-replacesable-pattern before))
         (--ehf-base-split-pattern-at-empty-line after)))
    (list (--ehf-base-ensure-replacesable-pattern pattern))))

(defun --ehf-base-with-buffer
    (file-path fn)
  "Execute FN with proper buffer handling for FILE-PATH."
  (let*
      ((existing-buf
        (and file-path
             (get-file-buffer file-path)))
       (buf
        (or existing-buf
            (if file-path
                (find-file-noselect file-path)
              (current-buffer)))))
    (with-current-buffer buf
      (funcall fn))
    (when
        (and file-path
             (not existing-buf))
      (save-buffer)
      (kill-buffer buf))))

(defun --ehf-base-insert-header
    (template format-fn file-path n-newlines)
  "Insert header using TEMPLATE and FORMAT-FN."
  (--ehf-base-with-buffer file-path
                          (lambda
                            ()
                            (let
                                ((formatted-header
                                  (funcall format-fn
                                           (buffer-file-name))))
                              (save-excursion
                                (goto-char
                                 (point-min))
                                (insert formatted-header)
                                (insert
                                 (make-string
                                  (or n-newlines 1)
                                  ?\n)))))))

(defun --ehf-base-insert-footer
    (format-fn file-path n-newlines)
  "Insert footer using FORMAT-FN."
  (--ehf-base-with-buffer file-path
                          (lambda
                            ()
                            (save-excursion
                              (goto-char
                               (point-max))
                              (delete-blank-lines)
                              (insert
                               (make-string
                                (or n-newlines 1)
                                ?\n))
                              (insert
                               (funcall format-fn
                                        (buffer-file-name)))))))

(defun --ehf-base-remove-headers
    (pattern extension file-path)
  "Remove headers using PATTERN."
  (let ((patterns (--ehf-base-split-pattern-at-empty-line pattern))
        (inhibit-message t))
    (--ehf-base-with-buffer file-path
                            (lambda ()
                              (when
                                  (equal
                                   (file-name-extension
                                    (buffer-file-name))
                                   extension)
                                (with-silent-modifications
                                  (save-excursion
                                    (dolist (current-pattern patterns)
                                      (goto-char (point-max))
                                      (let ((found-header nil))
                                        (while
                                            (re-search-backward
                                             current-pattern nil t)
                                          (setq found-header t)
                                          (delete-region
                                           (match-beginning 0)
                                           (match-end 0))
                                          (goto-char
                                           (match-beginning 0))
                                          (delete-blank-lines)))))))))))

(defun --ehf-base-remove-footers
    (pattern extension file-path)
  "Remove footers using PATTERN."
  (save-excursion
    (let ((patterns
           (--ehf-base-split-pattern-at-empty-line
            pattern)))
      (--ehf-base-with-buffer file-path
                              (lambda
                                ()
                                (when
                                    (equal
                                     (file-name-extension
                                      (buffer-file-name))
                                     extension)
                                  (with-silent-modifications
                                    (save-excursion
                                      (dolist
                                          (current-pattern patterns)
                                        (let ((footer-start nil)
                                              (footer-end nil)
                                              (found-footer nil))
                                          ;; (message "Using pattern: %S"
                                          ;;          current-pattern)
                                          ;; Find all instances of the footer pattern
                                          (goto-char (point-max))
                                          (while
                                              (re-search-backward
                                               current-pattern nil t)
                                            (setq footer-start
                                                  (match-beginning 0)
                                                  footer-end
                                                  (match-end 0)
                                                  found-footer t)
                                            ;; (message
                                            ;;  "Found footer at position %d to %d"
                                            ;;  footer-start footer-end)
                                            ;; Delete this footer instance
                                            (delete-region
                                             footer-start
                                             footer-end)
                                            ;; (message
                                            ;;  "Deleted footer content")
                                            ;; Clean up blank lines after deletion
                                            (goto-char footer-start)
                                            (delete-blank-lines)
                                            ;; (message
                                            ;;  "Cleaned up blank lines")
                                            )
                                          ;; (message
                                          ;;  "Footer removal complete - found footers: %s"
                                          ;;  (if found-footer "yes"
                                          ;;    "no"))
                                          (goto-char (point-max))))))))))))

(defun --ehf-base-update-header-and-footer
    (expected-routed-ext
     header-template
     header-pattern
     header-format-fn
     footer-template
     footer-pattern
     footer-format-fn
     &optional
     file-path
     n-new-lines)
  "Update header and footer using specified templates and formatters."
  (let*
      ((buffer-path
        (or file-path buffer-file-name))
       (ext
        (file-name-extension buffer-path))
       (routed-ext
        (--ehf-route-ext ext)))
    (when
        (equal routed-ext expected-routed-ext)
      (--ehf-base-remove-headers header-pattern ext file-path)
      (--ehf-base-insert-header header-template header-format-fn
                                file-path n-new-lines)
      (--ehf-base-remove-footers footer-pattern ext file-path)
      (--ehf-base-insert-footer footer-format-fn file-path n-new-lines))))

(when
    (not load-file-name)
  ;; (message "ehf-base.el loaded."
  ;;          (file-name-nondirectory
  ;;           (or load-file-name buffer-file-name)))
  )

(provide 'ehf-base)

(when
    (not load-file-name)
  (message "ehf-base.el loaded."
           (file-name-nondirectory
            (or load-file-name buffer-file-name))))