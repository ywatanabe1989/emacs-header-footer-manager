;;; -*- coding: utf-8; lexical-binding: t -*-
;;; Author: ywatanabe
;;; Timestamp: <2025-02-14 05:03:00>
;;; File: /home/ywatanabe/.emacs.d/lisp/emacs-header-footer/ehf.el
;;; Copyright (C) 2024-2025 Yusuke Watanabe (ywatanabe@alumni.u-tokyo.ac.jp)

;; Add to load path
(add-to-list 'load-path
             (file-name-directory
              (or load-file-name buffer-file-name)))

;; Base
(require 'ehf-variables)
(require 'ehf-registry)
(require 'ehf-base)

;; Language-specific versions
(require 'ehf-elisp)
(require 'ehf-markdown)
(require 'ehf-org)
(require 'ehf-python)
(require 'ehf-shell)
(require 'ehf-tex)
(require 'ehf-yaml)

;; Global version
(require 'ehf-update-header-and-footer)

;; Dired version
(require 'ehf-dired)

(provide 'ehf)

(when
    (not load-file-name)
  (message "ehf.el loaded."
           (file-name-nondirectory
            (or load-file-name buffer-file-name))))