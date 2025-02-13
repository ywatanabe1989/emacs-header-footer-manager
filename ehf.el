;;; -*- coding: utf-8; lexical-binding: t -*-
;;; Author: ywatanabe
;;; Timestamp: <2025-02-14 05:46:08>
;;; File: /home/ywatanabe/.emacs.d/lisp/emacs-header-footer/ehf.el
;;; Copyright (C) 2024-2025 Yusuke Watanabe (ywatanabe@alumni.u-tokyo.ac.jp)

;; Add to load path
(add-to-list 'load-path
             (file-name-directory
              (or load-file-name buffer-file-name)))

;; Core dependencies first
(require 'ehf-route-ext)
(require 'ehf-variables)
(require 'ehf-base)

;; Language-specific versions
(require 'ehf-elisp)
(require 'ehf-markdown)
(require 'ehf-org)
(require 'ehf-python)
(require 'ehf-shell)
(require 'ehf-tex)
(require 'ehf-yaml)

;; Features depending on core and language-specific
(require 'ehf-update-header-and-footer)
(require 'ehf-registry)

;; Additional features
(require 'ehf-dired)

(provide 'ehf)

(when
    (not load-file-name)
  (message "ehf.el loaded."
           (file-name-nondirectory
            (or load-file-name buffer-file-name))))