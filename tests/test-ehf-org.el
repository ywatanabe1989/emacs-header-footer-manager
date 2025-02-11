;;; -*- coding: utf-8; lexical-binding: t -*-
;;; Author: ywatanabe
;;; Timestamp: <2025-02-12 00:45:39>
;;; File: /home/ywatanabe/.dotfiles/.emacs.d/lisp/emacs-header-footer/tests/test-ehf-org.el

(require 'ert)
(require 'ehf-org)

(ert-deftest test-ehf-org-header-format
    ()
  (with-temp-buffer
    (let
        ((test-path "/test/file.org")
         (buffer-file-name "/test/file.org"))
      (--ehf-org-insert-header test-path)
      (goto-char
       (point-min))
      (should
       (looking-at --ehf-org-header-pattern)))))

(ert-deftest test-ehf-org-footer-format
    ()
  (with-temp-buffer
    (let
        ((test-path "/test/file.org")
         (buffer-file-name "/test/file.org"))
      (--ehf-org-insert-footer test-path)
      (goto-char
       (point-min))
      (should
       (string-match-p --ehf-org-footer-pattern
                       (buffer-string))))))

(ert-deftest test-ehf-org-update-both
    ()
  (with-temp-buffer
    (let
        ((test-path "/test/file.org")
         (buffer-file-name "/test/file.org"))
      (--ehf-org-update-header-and-footer test-path)
      (should
       (buffer-modified-p)))))

(provide 'test-ehf-org)

(provide 'test-ehf-org)

(when
    (not load-file-name)
  (message "test-ehf-org.el loaded."
           (file-name-nondirectory
            (or load-file-name buffer-file-name))))