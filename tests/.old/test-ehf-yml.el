;;; -*- coding: utf-8; lexical-binding: t -*-
;;; Author: ywatanabe
;;; Timestamp: <2025-02-12 10:06:15>
;;; File: /home/ywatanabe/.emacs.d/lisp/emacs-header-footer/tests/test-ehf-yml.el
;;; Copyright (C) 2024-2025 Yusuke Watanabe (ywatanabe@alumni.u-tokyo.ac.jp)

(require 'ert)
(require 'ehf-yml)

(ert-deftest test-ehf-yml-header-format
    ()
  (should
   (string-match-p "# Timestamp:"
                   (--ehf-yml-format-header "/tmp/test.yml"))))

(ert-deftest test-ehf-yml-footer-format
    ()
  (should
   (string=
    (--ehf-yml-format-footer)
    "# EOF")))

(ert-deftest test-ehf-yml-extension-check-yml
    ()
  (with-temp-buffer
    (setq buffer-file-name "/tmp/test.yml")
    (should
     (equal
      (file-name-extension buffer-file-name)
      "yml"))))

(provide 'test-ehf-yml)

(when
    (not load-file-name)
  (message "test-ehf-yml.el loaded."
           (file-name-nondirectory
            (or load-file-name buffer-file-name))))