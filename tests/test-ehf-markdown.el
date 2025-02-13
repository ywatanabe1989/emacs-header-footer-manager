;;; -*- coding: utf-8; lexical-binding: t -*-
;;; Author: ywatanabe
;;; Timestamp: <2025-02-14 05:21:12>
;;; File: /home/ywatanabe/.emacs.d/lisp/emacs-header-footer/tests/test-ehf-markdown.el

(require 'ert)
(require 'ehf-markdown)

(defconst test-file-extensions
  '("md"))

(ert-deftest test-ehf-markdown-format-header
    ()
  (dolist
      (ext test-file-extensions)
    (let
        ((test-path
          (format "/test/file.%s" ext))
         (buffer-file-name
          (format "/test/file.%s" ext)))
      (should
       (string-match-p --ehf-markdown-header-pattern
                       (--ehf-markdown-format-header test-path))))))

(ert-deftest test-ehf-markdown-format-footer
    ()
  (dolist
      (ext test-file-extensions)
    (let
        ((test-path
          (format "/test/file.%s" ext))
         (buffer-file-name
          (format "/test/file.%s" ext)))
      (should
       (string-match-p --ehf-markdown-footer-pattern
                       (--ehf-markdown-format-footer))))))

(ert-deftest test-ehf-markdown-update-header-and-footer
    ()
  (dolist
      (ext test-file-extensions)
    (with-temp-buffer
      (let
          ((test-path
            (format "/test/file.%s" ext))
           (buffer-file-name
            (format "/test/file.%s" ext)))
        (--ehf-markdown-update-header-and-footer test-path)
        (should
         (buffer-modified-p))))))

(provide 'test-ehf-markdown)

(when
    (not load-file-name)
  (message "test-ehf-markdown.el loaded."
           (file-name-nondirectory
            (or load-file-name buffer-file-name))))