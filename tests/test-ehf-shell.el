;;; -*- coding: utf-8; lexical-binding: t -*-
;;; Author: ywatanabe
;;; Timestamp: <2025-02-14 05:22:12>
;;; File: /home/ywatanabe/.emacs.d/lisp/emacs-header-footer/tests/test-ehf-shell.el

(require 'ert)
(require 'ehf-shell)

(defconst test-file-extensions
  '("sh"
    "bash"
    "def"
    "source"))

(ert-deftest test-ehf-shell-format-header
    ()
  (dolist
      (ext test-file-extensions)
    (let
        ((test-path
          (format "/test/file.%s" ext))
         (buffer-file-name
          (format "/test/file.%s" ext)))
      (should
       (string-match-p --ehf-shell-header-pattern
                       (--ehf-shell-format-header test-path))))))

(ert-deftest test-ehf-shell-format-footer
    ()
  (dolist
      (ext test-file-extensions)
    (let
        ((test-path
          (format "/test/file.%s" ext))
         (buffer-file-name
          (format "/test/file.%s" ext)))
      (should
       (string-match-p --ehf-shell-footer-pattern
                       (--ehf-shell-format-footer))))))

(ert-deftest test-ehf-shell-update-header-and-footer
    ()
  (dolist
      (ext test-file-extensions)
    (with-temp-buffer
      (let
          ((test-path
            (format "/test/file.%s" ext))
           (buffer-file-name
            (format "/test/file.%s" ext)))
        (--ehf-shell-update-header-and-footer test-path)
        (should
         (buffer-modified-p))))))

(provide 'test-ehf-shell)

(when
    (not load-file-name)
  (message "test-ehf-shell.el loaded."
           (file-name-nondirectory
            (or load-file-name buffer-file-name))))