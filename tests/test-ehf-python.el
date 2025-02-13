;;; -*- coding: utf-8; lexical-binding: t -*-
;;; Author: ywatanabe
;;; Timestamp: <2025-02-14 05:21:46>
;;; File: /home/ywatanabe/.emacs.d/lisp/emacs-header-footer/tests/test-ehf-python.el

(require 'ert)
(require 'ehf-python)

(defconst test-file-extensions
  '("py"))

(ert-deftest test-ehf-python-format-header
    ()
  (dolist
      (ext test-file-extensions)
    (let
        ((test-path
          (format "/test/file.%s" ext))
         (buffer-file-name
          (format "/test/file.%s" ext)))
      (should
       (string-match-p --ehf-python-header-pattern
                       (--ehf-python-format-header test-path))))))

(ert-deftest test-ehf-python-format-footer
    ()
  (dolist
      (ext test-file-extensions)
    (let
        ((test-path
          (format "/test/file.%s" ext))
         (buffer-file-name
          (format "/test/file.%s" ext)))
      (should
       (string-match-p --ehf-python-footer-pattern
                       (--ehf-python-format-footer))))))

(ert-deftest test-ehf-python-update-header-and-footer
    ()
  (dolist
      (ext test-file-extensions)
    (with-temp-buffer
      (let
          ((test-path
            (format "/test/file.%s" ext))
           (buffer-file-name
            (format "/test/file.%s" ext)))
        (--ehf-python-update-header-and-footer test-path)
        (should
         (buffer-modified-p))))))

(provide 'test-ehf-python)

(when
    (not load-file-name)
  (message "test-ehf-python.el loaded."
           (file-name-nondirectory
            (or load-file-name buffer-file-name))))