;;; -*- coding: utf-8; lexical-binding: t -*-
;;; Author: ywatanabe
;;; Timestamp: <2025-03-14 13:49:40>
;;; File: /home/ywatanabe/.emacs.d/lisp/emacs-header-footer/examples/example.el

;;; Copyright (C) 2025 Yusuke Watanabe (ywatanabe@alumni.u-tokyo.ac.jp)

(FILE CONTENTS HERE)

(provide 'example)

(when
    (not load-file-name)
  (message "example.el loaded."
           (file-name-nondirectory
            (or load-file-name buffer-file-name))))