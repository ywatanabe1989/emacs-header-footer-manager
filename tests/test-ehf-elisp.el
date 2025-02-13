;;; -*- coding: utf-8; lexical-binding: t -*-
;;; Author: ywatanabe
;;; Timestamp: <2025-02-14 05:20:57>
;;; File: /home/ywatanabe/.emacs.d/lisp/emacs-header-footer/tests/test-ehf-elisp.el

(require 'ert)
(require 'ehf-elisp)

(defconst test-file-extensions
  '("el"))

(ert-deftest test-ehf-elisp-format-header
    ()
  (dolist
      (ext test-file-extensions)
    (let
        ((test-path
          (format "/test/file.%s" ext))
         (buffer-file-name
          (format "/test/file.%s" ext)))
      (should
       (string-match-p --ehf-elisp-header-pattern
                       (--ehf-elisp-format-header test-path))))))

(ert-deftest test-ehf-elisp-format-footer
    ()
  (dolist
      (ext test-file-extensions)
    (let
        ((test-path
          (format "/test/file.%s" ext))
         (buffer-file-name
          (format "/test/file.%s" ext)))
      (should
       (string-match-p --ehf-elisp-footer-pattern
                       (--ehf-elisp-format-footer))))))

(ert-deftest test-ehf-elisp-update-header-and-footer
    ()
  (dolist
      (ext test-file-extensions)
    (with-temp-buffer
      (let
          ((test-path
            (format "/test/file.%s" ext))
           (buffer-file-name
            (format "/test/file.%s" ext)))
        (--ehf-elisp-update-header-and-footer test-path)
        (should
         (buffer-modified-p))))))

(provide 'test-ehf-elisp)

(when
    (not load-file-name)
  (message "test-ehf-elisp.el loaded."
           (file-name-nondirectory
            (or load-file-name buffer-file-name))))