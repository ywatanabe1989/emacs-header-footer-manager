;;; -*- coding: utf-8; lexical-binding: t -*-
;;; Author: ywatanabe
;;; Timestamp: <2025-04-17 07:09:27>
;;; File: /home/ywatanabe/.emacs.d/lisp/emacs-header-footer/ehf-route-ext.el

;;; Copyright (C) 2025 Yusuke Watanabe (ywatanabe@alumni.u-tokyo.ac.jp)

;; Main Function
;; ----------------------------------------

(defun --ehf-route-ext (ext)
  "Route extension EXT to canonical extension.
For example, yml -> yaml, bash -> sh"
  (let ((file-name (file-name-nondirectory (or buffer-file-name ""))))
    (cond
     ;; Handle specific filenames without extensions
     ((member file-name ehf-source-filenames)
      "source")
     ;; Shell scripts
     ((member ext ehf-shell-extensions)
      "sh")
     ;; Source
     ((member ext ehf-source-extensions)
      "source")
     ;; YAML files
     ((member ext ehf-yaml-extensions)
      "yaml")
     ;; LaTeX files
     ((member ext ehf-tex-extensions)
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
              '("el" "md" "org" "py" "html" "css" "js" "ts" "cpp" "c"
                "java" "go" "rs" "rb"))
      ext)
     (t nil))))

;; (defun --ehf-route-ext
;;     (ext)
;;   "Route extension EXT to canonical extension.
;; For example, yml -> yaml, bash -> sh"
;;   (cond

;;    ;; Shell scripts
;;    ((member ext ehf-shell-extensions)
;;     "sh")

;;    ;; Source
;;    ((member ext ehf-source-extensions)
;;     "source")

;;    ;; YAML files
;;    ((member ext ehf-yaml-extensions)
;;     "yaml")

;;    ;; LaTeX files
;;    ((member ext ehf-tex-extensions)
;;     "tex")

;;    ;; Web files
;;    ((or
;;      (equal ext "htm")
;;      (equal ext "xhtml"))
;;     "html")

;;    ;; Programming languages
;;    ((or
;;      (equal ext "cpp")
;;      (equal ext "cxx")
;;      (equal ext "cc"))
;;     "cpp")
;;    ((or
;;      (equal ext "js")
;;      (equal ext "jsx"))
;;     "js")
;;    ((or
;;      (equal ext "ts")
;;      (equal ext "tsx"))
;;     "ts")

;;    ;; Other types stay as-is
;;    ((member ext
;;             '("el" "md" "org" "py" "html" "css" "js" "ts" "cpp" "c"
;;               "java" "go" "rs" "rb"))
;;     ext)
;;    (t nil)))

;; ;; Before Save Hook
;; ;; ----------------------------------------
;; (add-hook 'before-save-hook #'ehf-update-header-and-footer)

(provide 'ehf-route-ext)

(when
    (not load-file-name)
  (message "ehf-route-ext.el loaded."
           (file-name-nondirectory
            (or load-file-name buffer-file-name))))