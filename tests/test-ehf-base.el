;;; -*- coding: utf-8; lexical-binding: t -*-
;;; Author: ywatanabe
;;; Timestamp: <2025-03-14 13:49:19>
;;; File: /home/ywatanabe/.emacs.d/lisp/emacs-header-footer/tests/test-ehf-base.el

;;; Copyright (C) 2025 Yusuke Watanabe (ywatanabe@alumni.u-tokyo.ac.jp)

(require 'ert)
(require 'ehf-base)

(ert-deftest test-ehf-base-with-buffer-insert
    ()
  (with-temp-buffer
    (--ehf-base-with-buffer
     nil
     (lambda
       ()
       (insert "test")))
    (should
     (string=
      (buffer-string)
      "test"))))

(ert-deftest test-ehf-base-insert-header-empty
    ()
  (with-temp-buffer
    (--ehf-base-insert-header
     ""
     (lambda
       (x)
       "")
     nil
     1)
    (should
     (string=
      (buffer-string)
      "\n"))))

(ert-deftest test-ehf-base-insert-header-content
    ()
  (with-temp-buffer
    (--ehf-base-insert-header
     "template"
     (lambda
       (x)
       "header")
     nil
     1)
    (should
     (string=
      (buffer-string)
      "header\n"))))

(ert-deftest test-ehf-base-insert-footer-empty
    ()
  (with-temp-buffer
    (--ehf-base-insert-footer
     (lambda
       (x)
       "")
     nil
     1)
    (should
     (string=
      (buffer-string)
      "\n"))))

(ert-deftest test-ehf-base-insert-footer-content
    ()
  (with-temp-buffer
    (--ehf-base-insert-footer
     (lambda
       (x)
       "footer")
     nil
     1)
    (should
     (string=
      (buffer-string)
      "\nfooter"))))

;; (ert-deftest test-ehf-base-remove-headers-match
;;     ()
;;   (with-temp-buffer
;;     (setq buffer-file-name "/tmp/test-file.txt")
;;     (insert "header\ntext")
;;     (--ehf-base-remove-headers
;;      "header"
;;      "txt"
;;      nil)
;;     (should
;;      (string=
;;       (buffer-string)
;;       "text"))))

;; (ert-deftest test-ehf-base-remove-footers-match
;;     ()
;;   (with-temp-buffer
;;     (setq buffer-file-name "/tmp/test-file.txt")
;;     (insert "text\nfooter")
;;     (--ehf-base-remove-footers
;;      "footer"
;;      "txt"
;;      nil)
;;     (should
;;      (string=
;;       (buffer-string)
;;       "text\n"))))

(provide 'test-ehf-base)

(when
    (not load-file-name)
  (message "test-ehf-base.el loaded."
           (file-name-nondirectory
            (or load-file-name buffer-file-name))))