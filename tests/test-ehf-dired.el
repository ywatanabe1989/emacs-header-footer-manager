;;; -*- coding: utf-8; lexical-binding: t -*-
;;; Author: ywatanabe
;;; Timestamp: <2025-02-12 00:45:16>
;;; File: /home/ywatanabe/.dotfiles/.emacs.d/lisp/emacs-header-footer/tests/test-ehf-dired.el

(require 'ert)
(require 'dired)

(ert-deftest test-ehf-dired-update-header-footer
    ()
  (let
      ((test-dir
        (make-temp-file "ehf-test-" t))
       (test-file "test.txt"))
    (unwind-protect
        (progn
          (with-temp-file
              (expand-file-name test-file test-dir)
            (insert "content"))
          (with-current-buffer
              (dired test-dir)
            (dired-mark-files-regexp
             (regexp-quote test-file))
            (ehf-dired-do-update-header-footer)
            (should
             (file-exists-p
              (expand-file-name test-file test-dir)))))
      (delete-directory test-dir t))))

(provide 'test-ehf-dired)

(when
    (not load-file-name)
  (message "test-ehf-dired.el loaded."
           (file-name-nondirectory
            (or load-file-name buffer-file-name))))