;;; -*- coding: utf-8; lexical-binding: t -*-
;;; Author: ywatanabe
;;; Timestamp: <2025-03-14 13:49:21>
;;; File: /home/ywatanabe/.emacs.d/lisp/emacs-header-footer/tests/test-ehf-shell.el

;;; Copyright (C) 2025 Yusuke Watanabe (ywatanabe@alumni.u-tokyo.ac.jp)

(require 'ert)
(require 'ehf-shell)

(ert-deftest test-ehf-shell-format-header
    ()
  (dolist
      (ext ehf-shell-extensions)
    (let
        ((test-path
          (format "/tmp/test-file.%s" ext))
         (buffer-file-name
          (format "/tmp/test-file.%s" ext)))
      (should
       (string-match-p --ehf-shell-header-pattern
                       (--ehf-shell-format-header test-path))))))

(ert-deftest test-ehf-shell-format-footer
    ()
  (dolist
      (ext ehf-shell-extensions)
    (let
        ((test-path
          (format "/tmp/test-file.%s" ext))
         (buffer-file-name
          (format "/tmp/test-file.%s" ext)))
      (should
       (string-match-p --ehf-shell-footer-pattern
                       (--ehf-shell-format-footer))))))

(ert-deftest test-ehf-shell-update-header-and-footer
    ()
  (dolist
      (ext ehf-shell-extensions)
    (with-temp-buffer
      (let
          ((test-path
            (format "/tmp/test-file.%s" ext))
           (buffer-file-name
            (format "/tmp/test-file.%s" ext)))
        ;; Set buffer as unmodified initially
        (set-buffer-modified-p nil)
        ;; Perform update
        (--ehf-shell-update-header-and-footer)
        ;; Check content was modified
        (should
         (>
          (buffer-size)
          0))))))

(provide 'test-ehf-shell)

(when
    (not load-file-name)
  (message "test-ehf-shell.el loaded."
           (file-name-nondirectory
            (or load-file-name buffer-file-name))))