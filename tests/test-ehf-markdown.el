;;; -*- coding: utf-8; lexical-binding: t -*-
;;; Author: ywatanabe
;;; Timestamp: <2025-02-14 15:02:01>
;;; File: /home/ywatanabe/.emacs.d/lisp/emacs-header-footer/tests/test-ehf-markdown.el

(require 'ert)
(require 'ehf-markdown)
(require 'ehf-variables)

(ert-deftest test-ehf-markdown-format-header
    ()
  (dolist
      (ext ehf-markdown-extensions)
    (let
        ((test-path
          (format "/tmp/test-file.%s" ext))
         (buffer-file-name
          (format "/tmp/test-file.%s" ext)))
      (should
       (string-match-p --ehf-markdown-header-pattern
                       (--ehf-markdown-format-header test-path))))))

(ert-deftest test-ehf-markdown-format-footer
    ()
  (dolist
      (ext ehf-markdown-extensions)
    (let
        ((test-path
          (format "/tmp/test-file.%s" ext))
         (buffer-file-name
          (format "/tmp/test-file.%s" ext)))
      (should
       (string-match-p --ehf-markdown-footer-pattern
                       (--ehf-markdown-format-footer))))))

(ert-deftest test-ehf-markdown-update-header-and-footer
    ()
  (dolist
      (ext ehf-markdown-extensions)
    (with-temp-buffer
      (let
          ((test-path
            (format "/tmp/test-file.%s" ext))
           (buffer-file-name
            (format "/tmp/test-file.%s" ext)))
        ;; Set buffer as unmodified initially
        (set-buffer-modified-p nil)
        ;; Perform update
        (--ehf-markdown-update-header-and-footer)
        ;; Check content was modified
        (sleep-for 1)
        (should
         (>
          (buffer-size)
          0))))))

(provide 'test-ehf-markdown)

(when
    (not load-file-name)
  (message "test-ehf-markdown.el loaded."
           (file-name-nondirectory
            (or load-file-name buffer-file-name))))
