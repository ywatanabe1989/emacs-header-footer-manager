;;; -*- coding: utf-8; lexical-binding: t -*-
;;; Author: ywatanabe
;;; Timestamp: <2025-03-14 13:49:22>
;;; File: /home/ywatanabe/.emacs.d/lisp/emacs-header-footer/tests/test-ehf-tex.el

;;; Copyright (C) 2025 Yusuke Watanabe (ywatanabe@alumni.u-tokyo.ac.jp)

(require 'ert)
(require 'ehf-tex)

(ert-deftest test-ehf-tex-format-header
    ()
  (dolist
      (ext ehf-tex-extensions)
    (let
        ((test-path
          (format "/tmp/test-file.%s" ext))
         (buffer-file-name
          (format "/tmp/test-file.%s" ext)))
      (should
       (string-match-p --ehf-tex-header-pattern
                       (--ehf-tex-format-header test-path))))))

(ert-deftest test-ehf-tex-format-footer
    ()
  (dolist
      (ext ehf-tex-extensions)
    (let
        ((test-path
          (format "/tmp/test-file.%s" ext))
         (buffer-file-name
          (format "/tmp/test-file.%s" ext)))
      (should
       (string-match-p --ehf-tex-footer-pattern
                       (--ehf-tex-format-footer))))))

(ert-deftest test-ehf-tex-update-header-and-footer
    ()
  (dolist
      (ext ehf-tex-extensions)
    (with-temp-buffer
      (let
          ((test-path
            (format "/tmp/test-file.%s" ext))
           (buffer-file-name
            (format "/tmp/test-file.%s" ext)))
        ;; Set buffer as unmodified initially
        (set-buffer-modified-p nil)
        ;; Perform update
        (--ehf-tex-update-header-and-footer)
        ;; Check content was modified
        (should
         (>
          (buffer-size)
          0))))))

(provide 'test-ehf-tex)

(when
    (not load-file-name)
  (message "test-ehf-tex.el loaded."
           (file-name-nondirectory
            (or load-file-name buffer-file-name))))