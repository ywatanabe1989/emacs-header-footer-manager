;;; -*- coding: utf-8; lexical-binding: t -*-
;;; Author: ywatanabe
;;; Timestamp: <2025-03-14 13:49:30>
;;; File: /home/ywatanabe/.emacs.d/lisp/emacs-header-footer/ehf-registry.el

;;; Copyright (C) 2025 Yusuke Watanabe (ywatanabe@alumni.u-tokyo.ac.jp)

;; Exclusion Functions
;; ----------------------------------------

(defun ehf-register-exclude-file
    ()
  "Add current buffer file or marked files in dired to `ehf-exclude-files`."
  (interactive)
  (if
      (derived-mode-p 'dired-mode)
      (dolist
          (file
           (dired-get-marked-files))
        (add-to-list 'ehf-exclude-files
                     (expand-file-name file))
        (message "Added %s to exclusion list" file))
    (if buffer-file-name
        (progn
          (add-to-list 'ehf-exclude-files
                       (expand-file-name buffer-file-name))
          (message "Added %s to exclusion list" buffer-file-name))
      (message "No file to register"))))

(defun ehf-unregister-exclude-file
    ()
  "Remove current buffer file or marked files in dired from `ehf-exclude-files`."
  (interactive)
  (if
      (derived-mode-p 'dired-mode)
      (dolist
          (file
           (dired-get-marked-files))
        (setq ehf-exclude-files
              (delete
               (expand-file-name file)
               ehf-exclude-files))
        (message "Removed %s from exclusion list" file))
    (if buffer-file-name
        (progn
          (setq ehf-exclude-files
                (delete
                 (expand-file-name buffer-file-name)
                 ehf-exclude-files))
          (message "Removed %s from exclusion list" buffer-file-name))
      (message "No file to unregister"))))

(defun ehf-toggle-exclude-file
    ()
  "Toggle current buffer file or marked files in dired in `ehf-exclude-files`."
  (interactive)
  (if
      (derived-mode-p 'dired-mode)
      (dolist
          (file
           (dired-get-marked-files))
        (let
            ((expanded-file
              (expand-file-name file)))
          (if
              (member expanded-file ehf-exclude-files)
              (progn
                (setq ehf-exclude-files
                      (delete expanded-file ehf-exclude-files))
                (message "Removed %s from exclusion list" file))
            (add-to-list 'ehf-exclude-files expanded-file)
            (message "Added %s to exclusion list" file))))
    (if buffer-file-name
        (let
            ((expanded-file
              (expand-file-name buffer-file-name)))
          (if
              (member expanded-file ehf-exclude-files)
              (progn
                (setq ehf-exclude-files
                      (delete expanded-file ehf-exclude-files))
                (message "Removed %s from exclusion list"
                         buffer-file-name))
            (add-to-list 'ehf-exclude-files expanded-file)
            (message "Added %s to exclusion list" buffer-file-name)))
      (message "No file to toggle"))))

;; ;; Key Bindings
;; ;; ----------------------------------------
;; (global-set-key (kbd "C-c <delete>") 'ehf-toggle-exclude-file)

(provide 'ehf-registry)

(when
    (not load-file-name)
  (message "ehf-registry.el loaded."
           (file-name-nondirectory
            (or load-file-name buffer-file-name))))