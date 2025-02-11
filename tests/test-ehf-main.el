;;; -*- coding: utf-8; lexical-binding: t -*-
;;; Author: ywatanabe
;;; Timestamp: <2025-02-11 23:12:37>
;;; File: /home/ywatanabe/.dotfiles/.emacs.d/lisp/emacs-header-footer/tests/test-ehf-main.el

(require 'ert)
(require 'ehf-main)
(require 'ehf-variables)

(ert-deftest test-ehf-main-loadable
    ()
  (should
   (featurep 'ehf-main)))

(ert-deftest test-ehf-main-excluded-file
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

(ert-deftest test-ehf-main-supported-extensions
    ()
  (let
      ((test-extensions
        '("el" "md" "org" "py" "sh" "tex" "yaml" "yml")))
    (dolist
        (ext test-extensions)
      (let*
          ((test-file
            (concat "/test/file." ext))
           (buffer-file-name test-file))
        (ehf-update-header-and-footer)))))

(provide 'test-ehf-main)

(when
    (not load-file-name)
  (message "test-ehf-main.el loaded."
           (file-name-nondirectory
            (or load-file-name buffer-file-name))))