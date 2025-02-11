;;; -*- coding: utf-8; lexical-binding: t -*-
;;; Author: ywatanabe
;;; Timestamp: <2025-02-11 23:10:36>
;;; File: /home/ywatanabe/.dotfiles/.emacs.d/lisp/emacs-header-footer/tests/test-ehf-elisp.el

(require 'ert)
(require 'ehf-elisp)

(ert-deftest test-ehf-elisp-loadable
    ()
  (should
   (featurep 'ehf-elisp)))

(ert-deftest test-ehf-elisp-header-format
    ()
  (with-temp-buffer
    (let
        ((test-path "/test/file.el")
         (buffer-file-name "/test/file.el"))
      (--ehf-elisp-insert-header test-path)
      (goto-char
       (point-min))
      (should
       (looking-at --ehf-elisp-header-pattern)))))

(ert-deftest test-ehf-elisp-footer-format
    ()
  (with-temp-buffer
    (let
        ((test-path "/test/file.el")
         (buffer-file-name "/test/file.el"))
      (--ehf-elisp-insert-footer test-path)
      (goto-char
       (point-min))
      (should
       (string-match-p --ehf-elisp-footer-pattern
                       (buffer-string))))))

(ert-deftest test-ehf-elisp-update-both
    ()
  (with-temp-buffer
    (let
        ((test-path "/test/file.el")
         (buffer-file-name "/test/file.el"))
      (--ehf-elisp-update-header-and-footer test-path)
      (should
       (buffer-modified-p)))))

(provide 'test-ehf-elisp)

(provide 'test-ehf-elisp)

(when
    (not load-file-name)
  (message "test-ehf-elisp.el loaded."
           (file-name-nondirectory
            (or load-file-name buffer-file-name))))