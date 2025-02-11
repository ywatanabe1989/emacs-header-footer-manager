;;; -*- coding: utf-8; lexical-binding: t -*-
;;; Author: ywatanabe
;;; Timestamp: <2025-02-12 00:45:09>
;;; File: /home/ywatanabe/.dotfiles/.emacs.d/lisp/emacs-header-footer/tests/test-ehf-base.el

(require 'ert)

;; Header
(ert-deftest test-ehf-base-insert-header
    ()
  (with-temp-buffer
    (let
        ((test-template "Test: %s")
         (test-format-fn
          (lambda
            (path)
            (format "Test: %s" path)))
         (test-path "/test/path")
         (test-newlines 2))
      (--ehf-base-insert-header test-template test-format-fn test-path test-newlines)
      (should
       (string=
        (buffer-string)
        (concat "Test: /test/path\n\n"))))))

;; Footer
(ert-deftest test-ehf-base-insert-footer
    ()
  (with-temp-buffer
    (let
        ((test-format-fn
          (lambda
            (path)
            "EOF"))
         (test-path "/test/path")
         (test-newlines 2))
      (--ehf-base-insert-footer test-format-fn test-path test-newlines)
      (should
       (string=
        (buffer-string)
        (concat "\n\nEOF"))))))

;; Remove Headers
(ert-deftest test-ehf-base-remove-headers
    ()
  (with-temp-buffer
    (let
        ((test-header "Header\nContent")
         (test-pattern "\\(Header\n\\)")
         (test-extension "txt"))
      (insert test-header)
      (setq buffer-file-name "test.txt")
      (--ehf-base-remove-headers test-pattern test-extension nil)
      (should
       (string=
        (buffer-string)
        "Content")))))

;; Remove Footers
(ert-deftest test-ehf-base-remove-footers
    ()
  (with-temp-buffer
    (let
        ((test-content "Content\nFooter")
         (test-pattern "\\(Footer\\)")
         (test-extension "txt"))
      (insert test-content)
      (setq buffer-file-name "test.txt")
      (--ehf-base-remove-footers test-pattern test-extension nil)
      (should
       (string=
        (buffer-string)
        "Content\n")))))

(provide 'test-ehf-base)

(provide 'test-ehf-base)

(when
    (not load-file-name)
  (message "test-ehf-base.el loaded."
           (file-name-nondirectory
            (or load-file-name buffer-file-name))))