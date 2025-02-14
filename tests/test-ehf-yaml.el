;;; -*- coding: utf-8; lexical-binding: t -*-
;;; Author: ywatanabe
;;; Timestamp: <2025-02-14 15:03:17>
;;; File: /home/ywatanabe/.emacs.d/lisp/emacs-header-footer/tests/test-ehf-yaml.el

(require 'ert)
(require 'ehf-yaml)

(ert-deftest test-ehf-yaml-format-header
    ()
  (dolist
      (ext yaml-extensions)
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
      (ext yaml-extensions)
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
      (ext yaml-extensions)
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