;;; -*- coding: utf-8; lexical-binding: t -*-
;;; Author: ywatanabe
;;; Timestamp: <2025-02-11 23:37:14>
;;; File: /home/ywatanabe/.dotfiles/.emacs.d/lisp/emacs-header-footer/tests/test-ehf-yaml.el
;;; Copyright (C) 2024-2025 Yusuke Watanabe (ywatanabe@alumni.u-tokyo.ac.jp)

(require 'ert)
(require 'ehf-yaml)

(ert-deftest test-ehf-yaml-loadable
    ()
  (should
   (featurep 'ehf-yaml)))

(ert-deftest test-ehf-yaml-header-format
    ()
  (should
   (string-match-p "# Timestamp:"
                   (--ehf-yaml-format-header "/tmp/test.yml"))))

(ert-deftest test-ehf-yaml-footer-format
    ()
  (should
   (string=
    (--ehf-yaml-format-footer)
    "# EOF")))

(ert-deftest test-ehf-yaml-extension-check-yaml
    ()
  (with-temp-buffer
    (setq buffer-file-name "/tmp/test.yaml")
    (should
     (equal
      (file-name-extension buffer-file-name)
      "yaml"))))

(ert-deftest test-ehf-yaml-extension-check-yml
    ()
  (with-temp-buffer
    (setq buffer-file-name "/tmp/test.yml")
    (should
     (equal
      (file-name-extension buffer-file-name)
      "yml"))))

(provide 'test-ehf-yaml)

(when
    (not load-file-name)
  (message "test-ehf-yaml.el loaded."
           (file-name-nondirectory
            (or load-file-name buffer-file-name))))