;;; -*- coding: utf-8; lexical-binding: t -*-
;;; Author: ywatanabe
;;; Timestamp: <2025-02-12 00:45:29>
;;; File: /home/ywatanabe/.dotfiles/.emacs.d/lisp/emacs-header-footer/tests/test-ehf-update-header-and-footer.el

(require 'ert)
(require 'ehf-update-header-and-footer)
(require 'ehf-variables)

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

(ert-deftest test-ehf-update-header-and-footer-supported-extensions
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

(provide 'test-ehf-update-header-and-footer)

(when
    (not load-file-name)
  (message "test-ehf-update-header-and-footer.el loaded."
           (file-name-nondirectory
            (or load-file-name buffer-file-name))))