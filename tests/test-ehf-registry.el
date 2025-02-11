;;; -*- coding: utf-8; lexical-binding: t -*-
;;; Author: ywatanabe
;;; Timestamp: <2025-02-11 23:15:42>
;;; File: /home/ywatanabe/.dotfiles/.emacs.d/lisp/emacs-header-footer/tests/test-ehf-registry.el

(require 'ert)
(require 'ehf-registry)
(require 'ehf-variables)

(ert-deftest test-ehf-registry-loadable
    ()
  (should
   (featurep 'ehf-registry)))

(ert-deftest test-ehf-registry-register-file
    ()
  (let
      ((test-file "/test/file.txt")
       (buffer-file-name "/test/file.txt")
       (ehf-exclude-files nil))
    (ehf-register-exclude-file)
    (should
     (member
      (expand-file-name test-file)
      ehf-exclude-files))))

(ert-deftest test-ehf-registry-unregister-file
    ()
  (let
      ((test-file "/test/file.txt")
       (buffer-file-name "/test/file.txt")
       (ehf-exclude-files
        (list
         (expand-file-name "/test/file.txt"))))
    (ehf-unregister-exclude-file)
    (should-not
     (member
      (expand-file-name test-file)
      ehf-exclude-files))))

(ert-deftest test-ehf-registry-toggle-file
    ()
  (let
      ((test-file "/test/file.txt")
       (buffer-file-name "/test/file.txt")
       (ehf-exclude-files nil))
    (ehf-toggle-exclude-file)
    (should
     (member
      (expand-file-name test-file)
      ehf-exclude-files))
    (ehf-toggle-exclude-file)
    (should-not
     (member
      (expand-file-name test-file)
      ehf-exclude-files))))

(provide 'test-ehf-registry)

(when
    (not load-file-name)
  (message "test-ehf-registry.el loaded."
           (file-name-nondirectory
            (or load-file-name buffer-file-name))))