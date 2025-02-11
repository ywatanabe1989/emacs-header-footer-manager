;;; -*- coding: utf-8; lexical-binding: t -*-
;;; Author: ywatanabe
;;; Timestamp: <2025-02-11 23:09:30>
;;; File: /home/ywatanabe/.dotfiles/.emacs.d/lisp/emacs-header-footer/ehf-dired.el
;;; Copyright (C) 2024-2025 Yusuke Watanabe (ywatanabe@alumni.u-tokyo.ac.jp)

(require 'ehf-main)

;; Main
;; ----------------------------------------

(defun ehf-dired-do-update-header-footer
    ()
  "Apply header/footer updates to marked files."
  (interactive)
  (let
      ((marked-files
        (dired-get-marked-files)))
    (dolist
        (file marked-files)
      (when
          (and
           (file-exists-p file)
           (file-writable-p file))
        (let
            ((buf
              (find-file-noselect file t)))
          (with-current-buffer buf
            (let
                ((buffer-file-name
                  (expand-file-name file)))
              (ehf-update-header-and-footer)
              (save-buffer)))
          (kill-buffer buf))))))

;; Key Binding
;; ----------------------------------------

;; (define-key dired-mode-map
;;             (kbd "H")
;;             'ehf-dired-do-update-header-footer)

(provide 'ehf-dired)

(when
    (not load-file-name)
  (message "ehf-dired.el loaded."
           (file-name-nondirectory
            (or load-file-name buffer-file-name))))