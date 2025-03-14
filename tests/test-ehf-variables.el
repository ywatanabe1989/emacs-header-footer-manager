;;; -*- coding: utf-8; lexical-binding: t -*-
;;; Author: ywatanabe
;;; Timestamp: <2025-03-14 13:49:22>
;;; File: /home/ywatanabe/.emacs.d/lisp/emacs-header-footer/tests/test-ehf-variables.el

;;; Copyright (C) 2025 Yusuke Watanabe (ywatanabe@alumni.u-tokyo.ac.jp)

(require 'ert)
(require 'ehf-variables)

(ert-deftest test-ehf-exclude-files-exists
    ()
  (should
   (boundp 'ehf-exclude-files)))

(ert-deftest test-ehf-exclude-files-is-list
    ()
  (should
   (listp ehf-exclude-files)))

(provide 'test-ehf-variables)

(when
    (not load-file-name)
  (message "test-ehf-variables.el loaded."
           (file-name-nondirectory
            (or load-file-name buffer-file-name))))