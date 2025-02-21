;;; -*- coding: utf-8; lexical-binding: t -*-
;;; Author: ywatanabe
;;; Timestamp: <2025-02-14 15:02:11>
;;; File: /home/ywatanabe/.emacs.d/lisp/emacs-header-footer/tests/test-ehf-org.el

(require 'ert)
(require 'ehf-org)

(ert-deftest test-ehf-org-format-header
    ()
  (dolist
      (ext ehf-org-extensions)
    (let
        ((test-path
          (format "/tmp/test-file.%s" ext))
         (buffer-file-name
          (format "/tmp/test-file.%s" ext)))
      (should
       (string-match-p --ehf-org-header-pattern
                       (--ehf-org-format-header test-path))))))

(ert-deftest test-ehf-org-format-footer
    ()
  (dolist
      (ext ehf-org-extensions)
    (let
        ((test-path
          (format "/tmp/test-file.%s" ext))
         (buffer-file-name
          (format "/tmp/test-file.%s" ext)))
      (should
       (string-match-p --ehf-org-footer-pattern
                       (--ehf-org-format-footer))))))

(ert-deftest test-ehf-org-update-header-and-footer
    ()
  (dolist
      (ext ehf-org-extensions)
    (with-temp-buffer
      (let
          ((test-path
            (format "/tmp/test-file.%s" ext))
           (buffer-file-name
            (format "/tmp/test-file.%s" ext)))
        ;; Set buffer as unmodified initially
        (set-buffer-modified-p nil)
        ;; Perform update
        (--ehf-org-update-header-and-footer)
        ;; Check content was modified
        (sleep-for 1)
        (should
         (>
          (buffer-size)
          0))))))

(provide 'test-ehf-org)

(when
    (not load-file-name)
  (message "test-ehf-org.el loaded."
           (file-name-nondirectory
            (or load-file-name buffer-file-name))))