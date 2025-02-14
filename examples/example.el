;;; -*- coding: utf-8; lexical-binding: t -*-
;;; Author: ywatanabe
;;; Timestamp: <2025-02-14 15:24:12>
;;; File: /home/ywatanabe/.emacs.d/lisp/emacs-header-footer/examples/example.el

(FILE CONTENTS HERE)

(provide 'example)

(when
    (not load-file-name)
  (message "example.el loaded."
           (file-name-nondirectory
            (or load-file-name buffer-file-name))))