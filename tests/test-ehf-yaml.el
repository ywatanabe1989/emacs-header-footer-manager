;;; -*- coding: utf-8; lexical-binding: t -*-
;;; Author: ywatanabe
;;; Timestamp: <2025-02-14 05:20:31>
;;; File: /home/ywatanabe/.emacs.d/lisp/emacs-header-footer/tests/test-ehf-yaml.el

(require 'ert)
(require 'ehf-yaml)

(defconst test-file-extensions
  '("yaml"
    "yml"))

(ert-deftest test-ehf-yaml-format-header
    ()
  (dolist
      (ext test-file-extensions)
    (let
        ((test-path
          (format "/test/file.%s" ext))
         (buffer-file-name
          (format "/test/file.%s" ext)))
      (should
       (string-match-p --ehf-yaml-header-pattern
                       (--ehf-yaml-format-header test-path))))))

(ert-deftest test-ehf-yaml-format-footer
    ()
  (dolist
      (ext test-file-extensions)
    (let
        ((test-path
          (format "/test/file.%s" ext))
         (buffer-file-name
          (format "/test/file.%s" ext)))
      (should
       (string-match-p --ehf-yaml-footer-pattern
                       (--ehf-yaml-format-footer))))))

(ert-deftest test-ehf-yaml-update-header-and-footer
    ()
  (dolist
      (ext test-file-extensions)
    (with-temp-buffer
      (let
          ((test-path
            (format "/test/file.%s" ext))
           (buffer-file-name
            (format "/test/file.%s" ext)))
        (--ehf-yaml-update-header-and-footer test-path)
        (should
         (buffer-modified-p))))))

(provide 'test-ehf-yaml)

(when
    (not load-file-name)
  (message "test-ehf-yaml.el loaded."
           (file-name-nondirectory
            (or load-file-name buffer-file-name))))