;;; -*- coding: utf-8; lexical-binding: t -*-
;;; Author: ywatanabe
;;; Timestamp: <2025-02-14 05:02:59>
;;; File: /home/ywatanabe/.emacs.d/lisp/emacs-header-footer/ehf-base.el
;;; Copyright (C) 2025 Yusuke Watanabe (ywatanabe@alumni.u-tokyo.ac.jp)

(require 'ehf-route-ext)

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
  (--ehf-base-with-buffer file-path
                          (lambda
                            ()
                            (when
                                (equal
                                 (file-name-extension
                                  (buffer-file-name))
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
                                  (forward-line)))))))

(defun --ehf-base-remove-footers
    (pattern extension file-path)
  "Remove footers using PATTERN."
  (--ehf-base-with-buffer file-path
                          (lambda
                            ()
                            (when
                                (equal
                                 (file-name-extension
                                  (buffer-file-name))
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
                                   (point-max))))))))

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
      (--ehf-base-insert-header header-template header-format-fn file-path n-new-lines)
      (--ehf-base-remove-footers footer-pattern ext file-path)
      (--ehf-base-insert-footer footer-format-fn file-path n-new-lines))))

(provide 'ehf-base)

;; ;; Base functions
;; ;; ----------------------------------------

;; (defun --ehf-base-update-header-and-footer
;;     (header-template header-pattern header-format-fn
;;                      footer-template footer-pattern footer-format-fn)
;;   "Update header and footer using specified templates, patterns and formatters."
;;   (let
;;       ((ext
;;         (file-name-extension buffer-file-name)))
;;     (when ext
;;       (--ehf-base-remove-headers header-pattern ext nil)
;;       (--ehf-base-insert-header header-template header-format-fn nil 2)
;;       (--ehf-base-remove-footers footer-pattern ext nil)
;;       (--ehf-base-insert-footer footer-format-fn nil 2))))

;; (defun --ehf-base-insert-header
;;     (template format-fn file-path n-newlines)
;;   "Generic function to insert header using TEMPLATE and FORMAT-FN."
;;   (let*
;;       ((existing-buf
;;         (and file-path
;;              (get-file-buffer file-path)))
;;        (buf
;;         (or existing-buf
;;             (if file-path
;;                 (find-file-noselect file-path)
;;               (current-buffer))))
;;        (path
;;         (buffer-file-name buf))
;;        (n-newlines
;;         (or n-newlines 1))
;;        (formatted-header
;;         (funcall format-fn path)))
;;     (with-current-buffer buf
;;       (save-excursion
;;         (goto-char
;;          (point-min))
;;         (insert formatted-header)
;;         (insert
;;          (make-string n-newlines ?\n))))
;;     (when
;;         (and file-path
;;              (not existing-buf))
;;       (with-current-buffer buf
;;         (save-buffer))
;;       (kill-buffer buf))))

;; (defun --ehf-base-insert-footer
;;     (format-fn file-path n-newlines)
;;   "Generic function to insert footer using FORMAT-FN."
;;   (let*
;;       ((existing-buf
;;         (and file-path
;;              (get-file-buffer file-path)))
;;        (buf
;;         (or existing-buf
;;             (if file-path
;;                 (find-file-noselect file-path)
;;               (current-buffer))))
;;        (path
;;         (buffer-file-name buf))
;;        (n-newlines
;;         (or n-newlines 1)))
;;     (with-current-buffer buf
;;       (save-excursion
;;         (goto-char
;;          (point-max))
;;         (delete-blank-lines)
;;         (insert
;;          (make-string n-newlines ?\n))
;;         (insert
;;          (funcall format-fn path))))
;;     (when
;;         (and file-path
;;              (not existing-buf))
;;       (with-current-buffer buf
;;         (save-buffer))
;;       (kill-buffer buf))))

;; (defun --ehf-base-remove-headers
;;     (pattern extension file-path)
;;   "Generic function to remove headers using PATTERN for files with EXTENSION."
;;   (let*
;;       ((existing-buf
;;         (and file-path
;;              (get-file-buffer file-path)))
;;        (buf
;;         (or existing-buf
;;             (if file-path
;;                 (find-file-noselect file-path)
;;               (current-buffer))))
;;        (path
;;         (buffer-file-name buf)))
;;     (when
;;         (equal
;;          (file-name-extension path)
;;          extension)
;;       (with-current-buffer buf
;;         (save-excursion
;;           (goto-char
;;            (point-min))
;;           (while
;;               (not
;;                (eobp))
;;             (when
;;                 (looking-at pattern)
;;               (delete-region
;;                (match-beginning 0)
;;                (match-end 0))
;;               (delete-blank-lines))
;;             (forward-line)))))
;;     (when
;;         (and file-path
;;              (not existing-buf))
;;       (with-current-buffer buf
;;         (save-buffer))
;;       (kill-buffer buf))))

;; (defun --ehf-base-remove-footers
;;     (pattern extension file-path)
;;   "Generic function to remove footers using PATTERN for files with EXTENSION."
;;   (let*
;;       ((existing-buf
;;         (and file-path
;;              (get-file-buffer file-path)))
;;        (buf
;;         (or existing-buf
;;             (if file-path
;;                 (find-file-noselect file-path)
;;               (current-buffer))))
;;        (path
;;         (buffer-file-name buf)))
;;     (when
;;         (equal
;;          (file-name-extension path)
;;          extension)
;;       (with-current-buffer buf
;;         (save-excursion
;;           (goto-char
;;            (point-max))
;;           (while
;;               (re-search-backward pattern nil t)
;;             (delete-region
;;              (match-beginning 0)
;;              (match-end 0))
;;             (goto-char
;;              (point-max))))))
;;     (when
;;         (and file-path
;;              (not existing-buf))
;;       (with-current-buffer buf
;;         (save-buffer))
;;       (kill-buffer buf))))

;; ;;;; Buffer is killed even when visiting a opened file
;; ;; (defun --ehf-base-insert-header
;; ;;     (template format-fn file-path n-newlines)
;; ;;   "Generic function to insert header using TEMPLATE and FORMAT-FN."
;; ;;   (let*
;; ;;       ((buf
;; ;;         (if file-path
;; ;;             (find-file-noselect file-path)
;; ;;           (current-buffer)))
;; ;;        (path
;; ;;         (buffer-file-name buf))
;; ;;        (n-newlines
;; ;;         (or n-newlines 1))
;; ;;        (formatted-header
;; ;;         (funcall format-fn path)))
;; ;;     (with-current-buffer buf
;; ;;       (save-excursion
;; ;;         (goto-char
;; ;;          (point-min))
;; ;;         (insert formatted-header)
;; ;;         (insert
;; ;;          (make-string n-newlines ?\n))))
;; ;;     (when file-path
;; ;;       (with-current-buffer buf
;; ;;         (save-buffer))
;; ;;       (kill-buffer buf))))

;; ;; (defun --ehf-base-insert-footer
;; ;;     (format-fn file-path n-newlines)
;; ;;   "Generic function to insert footer using FORMAT-FN."
;; ;;   (let*
;; ;;       ((buf
;; ;;         (if file-path
;; ;;             (find-file-noselect file-path)
;; ;;           (current-buffer)))
;; ;;        (path
;; ;;         (buffer-file-name buf))
;; ;;        (n-newlines
;; ;;         (or n-newlines 1)))
;; ;;     (with-current-buffer buf
;; ;;       (save-excursion
;; ;;         (goto-char
;; ;;          (point-max))
;; ;;         (delete-blank-lines)
;; ;;         (insert
;; ;;          (make-string n-newlines ?\n))
;; ;;         (insert
;; ;;          (funcall format-fn path))))
;; ;;     (when file-path
;; ;;       (with-current-buffer buf
;; ;;         (save-buffer))
;; ;;       (kill-buffer buf))))

;; ;; (defun --ehf-base-remove-headers
;; ;;     (pattern extension file-path)
;; ;;   "Generic function to remove headers using PATTERN for files with EXTENSION."
;; ;;   (let*
;; ;;       ((buf
;; ;;         (if file-path
;; ;;             (find-file-noselect file-path)
;; ;;           (current-buffer)))
;; ;;        (path
;; ;;         (buffer-file-name buf)))
;; ;;     (when
;; ;;         (equal
;; ;;          (file-name-extension path)
;; ;;          extension)
;; ;;       (with-current-buffer buf
;; ;;         (save-excursion
;; ;;           (goto-char
;; ;;            (point-min))
;; ;;           (while
;; ;;               (not
;; ;;                (eobp))
;; ;;             (when
;; ;;                 (looking-at pattern)
;; ;;               (delete-region
;; ;;                (match-beginning 0)
;; ;;                (match-end 0))
;; ;;               (delete-blank-lines))
;; ;;             (forward-line)))))
;; ;;     (when file-path
;; ;;       (with-current-buffer buf
;; ;;         (save-buffer))
;; ;;       (kill-buffer buf))))

;; ;; (defun --ehf-base-remove-footers
;; ;;     (pattern extension file-path)
;; ;;   "Generic function to remove footers using PATTERN for files with EXTENSION."
;; ;;   (let*
;; ;;       ((buf
;; ;;         (if file-path
;; ;;             (find-file-noselect file-path)
;; ;;           (current-buffer)))
;; ;;        (path
;; ;;         (buffer-file-name buf)))
;; ;;     (when
;; ;;         (equal
;; ;;          (file-name-extension path)
;; ;;          extension)
;; ;;       (with-current-buffer buf
;; ;;         (save-excursion
;; ;;           (goto-char
;; ;;            (point-max))
;; ;;           (while
;; ;;               (re-search-backward pattern nil t)
;; ;;             (delete-region
;; ;;              (match-beginning 0)
;; ;;              (match-end 0))
;; ;;             (goto-char
;; ;;              (point-max))))))
;; ;;     (when file-path
;; ;;       (with-current-buffer buf
;; ;;         (save-buffer))
;; ;;       (kill-buffer buf))))

;; (provide 'ehf-base)

;; (when
;;     (not load-file-name)
;;   (message "ehf-base.el loaded."
;;            (file-name-nondirectory
;;             (or load-file-name buffer-file-name))))

(provide 'ehf-base)

(when
    (not load-file-name)
  (message "ehf-base.el loaded."
           (file-name-nondirectory
            (or load-file-name buffer-file-name))))