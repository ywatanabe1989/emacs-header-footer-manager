;;; -*- coding: utf-8; lexical-binding: t -*-
;;; Author: ywatanabe
;;; Timestamp: <2025-02-12 00:45:55>
;;; File: /home/ywatanabe/.dotfiles/.emacs.d/lisp/emacs-header-footer/tests/test-ehf-shell.el

(require 'ert)
(require 'ehf-shell)

(ert-deftest test-ehf-shell-header-format
    ()
  (with-temp-buffer
    (let
        ((test-path "/test/file.sh")
         (buffer-file-name "/test/file.sh"))
      (--ehf-shell-insert-header test-path)
      (goto-char
       (point-min))
      (should
       (looking-at --ehf-shell-header-pattern)))))

(ert-deftest test-ehf-shell-footer-format
    ()
  (with-temp-buffer
    (let
        ((test-path "/test/file.sh")
         (buffer-file-name "/test/file.sh"))
      (--ehf-shell-insert-footer test-path)
      (goto-char
       (point-min))
      (should
       (string-match-p --ehf-shell-footer-pattern
                       (buffer-string))))))

(ert-deftest test-ehf-shell-update-both
    ()
  (with-temp-buffer
    (let
        ((test-path "/test/file.sh")
         (buffer-file-name "/test/file.sh"))
      (--ehf-shell-update-header-and-footer test-path)
      (should
       (buffer-modified-p)))))

(provide 'test-ehf-shell)

(provide 'test-ehf-shell)

(when
    (not load-file-name)
  (message "test-ehf-shell.el loaded."
           (file-name-nondirectory
            (or load-file-name buffer-file-name))))