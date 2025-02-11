;;; -*- coding: utf-8; lexical-binding: t -*-
;;; Author: ywatanabe
;;; Timestamp: <2025-02-11 23:17:20>
;;; File: /home/ywatanabe/.dotfiles/.emacs.d/lisp/emacs-header-footer/tests/test-ehf-tex.el

(require 'ert)
(require 'ehf-tex)

(ert-deftest test-ehf-tex-loadable
    ()
  (should
   (featurep 'ehf-tex)))

(ert-deftest test-ehf-tex-header-format
    ()
  (with-temp-buffer
    (let
        ((test-path "/test/file.tex")
         (buffer-file-name "/test/file.tex"))
      (--ehf-tex-insert-header test-path)
      (goto-char
       (point-min))
      (should
       (looking-at --ehf-tex-header-pattern)))))

(ert-deftest test-ehf-tex-footer-format
    ()
  (with-temp-buffer
    (let
        ((test-path "/test/file.tex")
         (buffer-file-name "/test/file.tex"))
      (--ehf-tex-insert-footer test-path)
      (goto-char
       (point-min))
      (should
       (string-match-p --ehf-tex-footer-pattern
                       (buffer-string))))))

(ert-deftest test-ehf-tex-update-both
    ()
  (with-temp-buffer
    (let
        ((test-path "/test/file.tex")
         (buffer-file-name "/test/file.tex"))
      (--ehf-tex-update-header-and-footer test-path)
      (should
       (buffer-modified-p)))))

(provide 'test-ehf-tex)

(provide 'test-ehf-tex)

(when
    (not load-file-name)
  (message "test-ehf-tex.el loaded."
           (file-name-nondirectory
            (or load-file-name buffer-file-name))))