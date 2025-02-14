;;; -*- coding: utf-8; lexical-binding: t -*-
;;; Author: ywatanabe
;;; Timestamp: <2025-02-14 15:01:40>
;;; File: /home/ywatanabe/.emacs.d/lisp/emacs-header-footer/tests/test-ehf-elisp.el

(require 'ert)
(require 'ehf-elisp)
(require 'ehf-variables)

(ert-deftest test-ehf-elisp-format-header
    ()
  (dolist
      (ext elisp-extensions)
    (let
        ((test-path
          (format "/tmp/test-file.%s" ext))
         (buffer-file-name
          (format "/tmp/test-file.%s" ext)))
      (should
       (string-match-p --ehf-elisp-header-pattern
                       (--ehf-elisp-format-header test-path))))))

(ert-deftest test-ehf-elisp-format-footer
    ()
  (dolist
      (ext elisp-extensions)
    (let
        ((test-path
          (format "/tmp/test-file.%s" ext))
         (buffer-file-name
          (format "/tmp/test-file.%s" ext)))
      (should
       (string-match-p --ehf-elisp-footer-pattern
                       (--ehf-elisp-format-footer))))))

(ert-deftest test-ehf-elisp-update-header-and-footer
    ()
  (dolist
      (ext elisp-extensions)
    (with-temp-buffer
      (let
          ((test-path
            (format "/tmp/test-file.%s" ext))
           (buffer-file-name
            (format "/tmp/test-file.%s" ext)))
        ;; Set buffer as unmodified initially
        (set-buffer-modified-p nil)
        ;; Perform update
        (--ehf-elisp-update-header-and-footer)
        ;; Check content was modified
        (should
         (>
          (buffer-size)
          0))))))

(provide 'test-ehf-elisp)

(when
    (not load-file-name)
  (message "test-ehf-elisp.el loaded."
           (file-name-nondirectory
            (or load-file-name buffer-file-name))))
