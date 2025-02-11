;;; -*- coding: utf-8; lexical-binding: t -*-
;;; Author: ywatanabe
;;; Timestamp: <2025-02-11 23:13:04>
;;; File: /home/ywatanabe/.dotfiles/.emacs.d/lisp/emacs-header-footer/tests/-test-ehf-markdown.el
(require 'ert)

(require 'ehf-markdown)

(ert-deftest test-ehf-markdown-loadable
    ()
  (should
   (featurep 'ehf-markdown)))

(ert-deftest test-ehf-markdown-header-format
    ()
  (with-temp-buffer
    (let
        ((test-path "/test/file.md")
         (buffer-file-name "/test/file.md"))
      (--ehf-markdown-insert-header test-path)
      (goto-char
       (point-min))
      (should
       (looking-at --ehf-markdown-header-pattern)))))

(ert-deftest test-ehf-markdown-footer-format
    ()
  (with-temp-buffer
    (let
        ((test-path "/test/file.md")
         (buffer-file-name "/test/file.md"))
      (--ehf-markdown-insert-footer test-path)
      (goto-char
       (point-min))
      (should
       (string-match-p --ehf-markdown-footer-pattern
                       (buffer-string))))))

(ert-deftest test-ehf-markdown-update-both
    ()
  (with-temp-buffer
    (let
        ((test-path "/test/file.md")
         (buffer-file-name "/test/file.md"))
      (--ehf-markdown-update-header-and-footer test-path)
      (should
       (buffer-modified-p)))))

(provide 'test-ehf-markdown)

(provide '-test-ehf-markdown)

(when
    (not load-file-name)
  (message "-test-ehf-markdown.el loaded."
           (file-name-nondirectory
            (or load-file-name buffer-file-name))))