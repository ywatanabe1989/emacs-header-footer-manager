;;; -*- coding: utf-8; lexical-binding: t -*-
;;; Author: ywatanabe
;;; Timestamp: <2025-03-14 13:49:19>
;;; File: /home/ywatanabe/.emacs.d/lisp/emacs-header-footer/tests/test-ehf.el

;;; Copyright (C) 2025 Yusuke Watanabe (ywatanabe@alumni.u-tokyo.ac.jp)

(require 'ert)

(ert-deftest test-ehf-base-loadable
    ()
  (require 'ehf-base)
  (should
   (featurep 'ehf-base)))

(ert-deftest test-ehf-variables-loadable
    ()
  (require 'ehf-variables)
  (should
   (featurep 'ehf-variables)))

(ert-deftest test-ehf-registry-loadable
    ()
  (require 'ehf-registry)
  (should
   (featurep 'ehf-registry)))

(ert-deftest test-ehf-elisp-loadable
    ()
  (require 'ehf-elisp)
  (should
   (featurep 'ehf-elisp)))

(ert-deftest test-ehf-markdown-loadable
    ()
  (require 'ehf-markdown)
  (should
   (featurep 'ehf-markdown)))

(ert-deftest test-ehf-org-loadable
    ()
  (require 'ehf-org)
  (should
   (featurep 'ehf-org)))

(ert-deftest test-ehf-python-loadable
    ()
  (require 'ehf-python)
  (should
   (featurep 'ehf-python)))

(ert-deftest test-ehf-shell-loadable
    ()
  (require 'ehf-shell)
  (should
   (featurep 'ehf-shell)))

(ert-deftest test-ehf-tex-loadable
    ()
  (require 'ehf-tex)
  (should
   (featurep 'ehf-tex)))

(ert-deftest test-ehf-yaml-loadable
    ()
  (require 'ehf-yaml)
  (should
   (featurep 'ehf-yaml)))

(ert-deftest test-ehf-update-header-and-footer-loadable
    ()
  (require 'ehf-update-header-and-footer)
  (should
   (featurep 'ehf-update-header-and-footer)))

(ert-deftest test-ehf-dired-loadable
    ()
  (require 'ehf-dired)
  (should
   (featurep 'ehf-dired)))

(ert-deftest test-ehf-route-ext-loadable
    ()
  (should
   (featurep 'ehf-route-ext)))

(provide 'test-ehf)

(when
    (not load-file-name)
  (message "test-ehf.el loaded."
           (file-name-nondirectory
            (or load-file-name buffer-file-name))))