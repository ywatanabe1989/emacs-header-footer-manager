;;; -*- coding: utf-8; lexical-binding: t -*-
;;; Author: ywatanabe
;;; Timestamp: <2025-03-14 13:49:22>
;;; File: /home/ywatanabe/.emacs.d/lisp/emacs-header-footer/tests/test-ehf-update-header-and-footer.el

;;; Copyright (C) 2025 Yusuke Watanabe (ywatanabe@alumni.u-tokyo.ac.jp)

(require 'ert)
(require 'ehf-update-header-and-footer)
(require 'ehf-variables)

(defvar extensions
  '("el" "md" "org" "py" "sh" "src" "tex" "yaml" "yml"))

(ert-deftest test-ehf-update-header-and-footer-excluded-file
    ()
  (let
      ((test-file "/test/path/file.el"))
    (add-to-list 'ehf-exclude-files test-file)
    (let
        ((buffer-file-name test-file))
      (ehf-update-header-and-footer)
      (should
       (member test-file ehf-exclude-files)))
    (setq ehf-exclude-files
          (delete test-file ehf-exclude-files))))

(ert-deftest
    test-ehf-update-header-and-footer-ehf-supported-extensions
    ()
  (dolist
      (ext extensions)
    (let*
        ((test-file
          (concat "/tmp/test-file." ext))
         (buffer-file-name test-file))
      (ehf-update-header-and-footer))))

(provide 'test-ehf-update-header-and-footer)

(when
    (not load-file-name)
  (message "test-ehf-update-header-and-footer.el loaded."
           (file-name-nondirectory
            (or load-file-name buffer-file-name))))