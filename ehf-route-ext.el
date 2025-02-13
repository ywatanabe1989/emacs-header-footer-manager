;;; -*- coding: utf-8; lexical-binding: t -*-
;;; Author: ywatanabe
;;; Timestamp: <2025-02-14 05:03:02>
;;; File: /home/ywatanabe/.emacs.d/lisp/emacs-header-footer/ehf-route-ext.el
;;; Copyright (C) 2024-2025 Yusuke Watanabe (ywatanabe@alumni.u-tokyo.ac.jp)

;; Main Function
;; ----------------------------------------

(defun --ehf-route-ext
    (ext)
  "Route extension EXT to canonical extension.
For example, yml -> yaml, bash -> sh"
  (cond

   ;; No extension or shell scripts
   ((or
     (null ext)
     (equal ext "def")
     (equal ext "bash")
     ;; (equal ext "zsh")
     ;; (equal ext "fish")
     ;; (equal ext "ksh")
     (equal ext "source")
     (equal ext "sh.source")
     (equal ext "conf")
     (equal ext "config")
     (equal ext "rc")
     (equal ext "profile"))
    "sh")

   ;; YAML files
   ((or
     (equal ext "yml")
     (equal ext "yml.template")
     (equal ext "yaml.template"))
    "yaml")

   ;; LaTeX files
   ((or
     (equal ext "latex")
     (equal ext "tex.template"))
    "tex")

   ;; Web files
   ((or
     (equal ext "htm")
     (equal ext "xhtml"))
    "html")

   ;; Programming languages
   ((or
     (equal ext "cpp")
     (equal ext "cxx")
     (equal ext "cc"))
    "cpp")
   ((or
     (equal ext "js")
     (equal ext "jsx"))
    "js")
   ((or
     (equal ext "ts")
     (equal ext "tsx"))
    "ts")
   ;; Other types stay as-is
   ((member ext
            '("el" "md" "org" "py" "sh" "tex" "yaml" "html" "css" "js" "ts" "cpp" "c" "java" "go" "rs" "rb"))
    ext)
   (t nil)))

;; ;; Before Save Hook
;; ;; ----------------------------------------
;; (add-hook 'before-save-hook #'ehf-update-header-and-footer)

(provide 'ehf-route-ext)

(when
    (not load-file-name)
  (message "ehf-route-ext.el loaded."
           (file-name-nondirectory
            (or load-file-name buffer-file-name))))