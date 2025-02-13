;;; -*- coding: utf-8; lexical-binding: t -*-
;;; Author: ywatanabe
;;; Timestamp: <2025-02-14 05:21:28>
;;; File: /home/ywatanabe/.emacs.d/lisp/emacs-header-footer/tests/test-ehf-org.el

(require 'ert)
(require 'ehf-org)

(defconst test-file-extensions
  '("org"))

(ert-deftest test-ehf-org-format-header
    ()
  (dolist
      (ext test-file-extensions)
    (let
        ((test-path
          (format "/test/file.%s" ext))
         (buffer-file-name
          (format "/test/file.%s" ext)))
      (should
       (string-match-p --ehf-org-header-pattern
                       (--ehf-org-format-header test-path))))))

(ert-deftest test-ehf-org-format-footer
    ()
  (dolist
      (ext test-file-extensions)
    (let
        ((test-path
          (format "/test/file.%s" ext))
         (buffer-file-name
          (format "/test/file.%s" ext)))
      (should
       (string-match-p --ehf-org-footer-pattern
                       (--ehf-org-format-footer))))))

(ert-deftest test-ehf-org-update-header-and-footer
    ()
  (dolist
      (ext test-file-extensions)
    (with-temp-buffer
      (let
          ((test-path
            (format "/test/file.%s" ext))
           (buffer-file-name
            (format "/test/file.%s" ext)))
        (--ehf-org-update-header-and-footer test-path)
        (should
         (buffer-modified-p))))))

(provide 'test-ehf-org)

(when
    (not load-file-name)
  (message "test-ehf-org.el loaded."
           (file-name-nondirectory
            (or load-file-name buffer-file-name))))