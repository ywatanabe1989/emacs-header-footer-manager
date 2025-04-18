;;; -*- coding: utf-8; lexical-binding: t -*-
;;; Author: ywatanabe
;;; Timestamp: <2025-04-18 11:25:00>
;;; File: /home/ywatanabe/.emacs.d/lisp/emacs-header-footer/tests/test-ehf-python.el

;;; Copyright (C) 2025 Yusuke Watanabe (ywatanabe@alumni.u-tokyo.ac.jp)

(require 'ert)
(require 'ehf-python)

(ert-deftest test-ehf-python-format-header
    ()
  (dolist
      (ext ehf-python-extensions)
    (let
        ((test-path
          (format "/tmp/test-file.%s" ext))
         (buffer-file-name
          (format "/tmp/test-file.%s" ext)))
      (should
       (string-match-p --ehf-python-header-pattern
                       (--ehf-python-format-header test-path))))))

(ert-deftest test-ehf-python-format-footer
    ()
  (dolist
      (ext ehf-python-extensions)
    (let
        ((test-path
          (format "/tmp/test-file.%s" ext))
         (buffer-file-name
          (format "/tmp/test-file.%s" ext)))
      (should
       (string-match-p --ehf-python-footer-pattern
                       (--ehf-python-format-footer))))))

(ert-deftest test-ehf-python-update-header-and-footer
    ()
  (dolist
      (ext ehf-python-extensions)
    (with-temp-buffer
      (let
          ((test-path
            (format "/tmp/test-file.%s" ext))
           (buffer-file-name
            (format "/tmp/test-file.%s" ext)))
        ;; Set buffer as unmodified initially
        (set-buffer-modified-p nil)
        ;; Perform update
        (--ehf-python-update-header-and-footer)
        ;; Check content was modified
        (should
         (>
          (buffer-size)
          0))))))

(provide 'test-ehf-python)

(when
    (not load-file-name)
  (message "test-ehf-python.el loaded."
           (file-name-nondirectory
            (or load-file-name buffer-file-name))))