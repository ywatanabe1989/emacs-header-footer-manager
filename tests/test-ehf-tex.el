;;; -*- coding: utf-8; lexical-binding: t -*-
;;; Author: ywatanabe
;;; Timestamp: <2025-02-14 05:22:30>
;;; File: /home/ywatanabe/.emacs.d/lisp/emacs-header-footer/tests/test-ehf-tex.el

(require 'ert)
(require 'ehf-elisp)

(defconst test-file-extensions
  '("tex"))

(ert-deftest test-ehf-tex-format-header
    ()
  (dolist
      (ext test-file-extensions)
    (let
        ((test-path
          (format "/test/file.%s" ext))
         (buffer-file-name
          (format "/test/file.%s" ext)))
      (should
       (string-match-p --ehf-tex-header-pattern
                       (--ehf-tex-format-header test-path))))))

(ert-deftest test-ehf-tex-format-footer
    ()
  (dolist
      (ext test-file-extensions)
    (let
        ((test-path
          (format "/test/file.%s" ext))
         (buffer-file-name
          (format "/test/file.%s" ext)))
      (should
       (string-match-p --ehf-tex-footer-pattern
                       (--ehf-tex-format-footer))))))

(ert-deftest test-ehf-tex-update-header-and-footer
    ()
  (dolist
      (ext test-file-extensions)
    (with-temp-buffer
      (let
          ((test-path
            (format "/test/file.%s" ext))
           (buffer-file-name
            (format "/test/file.%s" ext)))
        (--ehf-tex-update-header-and-footer test-path)
        (should
         (buffer-modified-p))))))

(provide 'test-ehf-tex)

(when
    (not load-file-name)
  (message "test-ehf-tex.el loaded."
           (file-name-nondirectory
            (or load-file-name buffer-file-name))))