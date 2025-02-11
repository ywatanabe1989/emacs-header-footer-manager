;;; -*- coding: utf-8; lexical-binding: t -*-
;;; Author: ywatanabe
;;; Timestamp: <2025-02-11 23:15:04>
;;; File: /home/ywatanabe/.dotfiles/.emacs.d/lisp/emacs-header-footer/tests/test-ehf-python.el
(require 'ert)
(require 'ehf-python)

(ert-deftest test-ehf-python-loadable
    ()
  (should
   (featurep 'ehf-python)))

(ert-deftest test-ehf-python-header-format
    ()
  (with-temp-buffer
    (let
        ((test-path "/test/file.py")
         (buffer-file-name "/test/file.py"))
      (--ehf-python-insert-header test-path)
      (goto-char
       (point-min))
      (should
       (looking-at --ehf-python-header-pattern)))))

(ert-deftest test-ehf-python-footer-format
    ()
  (with-temp-buffer
    (let
        ((test-path "/test/file.py")
         (buffer-file-name "/test/file.py"))
      (--ehf-python-insert-footer test-path)
      (goto-char
       (point-min))
      (should
       (string-match-p --ehf-python-footer-pattern
                       (buffer-string))))))

(ert-deftest test-ehf-python-update-both
    ()
  (with-temp-buffer
    (let
        ((test-path "/test/file.py")
         (buffer-file-name "/test/file.py"))
      (--ehf-python-update-header-and-footer test-path)
      (should
       (buffer-modified-p)))))

(provide 'test-ehf-python)

(when
    (not load-file-name)
  (message "test-ehf-python.el loaded."
           (file-name-nondirectory
            (or load-file-name buffer-file-name))))