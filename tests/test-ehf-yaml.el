;;; -*- coding: utf-8; lexical-binding: t -*-
;;; Author: ywatanabe
;;; Timestamp: <2025-03-14 13:49:23>
;;; File: /home/ywatanabe/.emacs.d/lisp/emacs-header-footer/tests/test-ehf-yaml.el

;;; Copyright (C) 2025 Yusuke Watanabe (ywatanabe@alumni.u-tokyo.ac.jp)

(require 'ert)
(require 'ehf-yaml)

(ert-deftest test-ehf-yaml-format-header
    ()
  (dolist
      (ext ehf-yaml-extensions)
    (let
        ((test-path
          (format "/tmp/test-file.%s" ext))
         (buffer-file-name
          (format "/tmp/test-file.%s" ext)))
      (should
       (string-match-p --ehf-yaml-header-pattern
                       (--ehf-yaml-format-header test-path))))))

(ert-deftest test-ehf-yaml-format-footer
    ()
  (dolist
      (ext ehf-yaml-extensions)
    (let
        ((test-path
          (format "/tmp/test-file.%s" ext))
         (buffer-file-name
          (format "/tmp/test-file.%s" ext)))
      (should
       (string-match-p --ehf-yaml-footer-pattern
                       (--ehf-yaml-format-footer))))))

(ert-deftest test-ehf-yaml-update-header-and-footer
    ()
  (dolist
      (ext ehf-yaml-extensions)
    (with-temp-buffer
      (let
          ((test-path
            (format "/tmp/test-file.%s" ext))
           (buffer-file-name
            (format "/tmp/test-file.%s" ext)))
        ;; Set buffer as unmodified initially
        (set-buffer-modified-p nil)
        ;; Perform update
        (--ehf-yaml-update-header-and-footer)
        ;; Check content was modified
        (should
         (>
          (buffer-size)
          0))))))

(provide 'test-ehf-yaml)

(when
    (not load-file-name)
  (message "test-ehf-yaml.el loaded."
           (file-name-nondirectory
            (or load-file-name buffer-file-name))))