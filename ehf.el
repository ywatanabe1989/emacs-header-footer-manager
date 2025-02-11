;;; -*- coding: utf-8; lexical-binding: t -*-
;;; Author: ywatanabe
;;; Timestamp: <2025-02-11 19:53:43>
;;; File: /home/ywatanabe/proj/elisp-header-footer/ehf.el
;;; Copyright (C) 2024-2025 Yusuke Watanabe (ywatanabe@alumni.u-tokyo.ac.jp)

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
(require 'ehf-main)

;; Dired version
(require 'ehf-dired)

(provide 'ehf)

(when
    (not load-file-name)
  (message "ehf.el loaded."
           (file-name-nondirectory
            (or load-file-name buffer-file-name))))