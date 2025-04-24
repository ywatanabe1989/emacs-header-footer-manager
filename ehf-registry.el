;;; -*- coding: utf-8; lexical-binding: t -*-
;;; Author: ywatanabe
;;; Timestamp: <2025-04-21 08:02:24>
;;; File: /home/ywatanabe/.emacs.d/lisp/emacs-header-footer/ehf-registry.el

;;; Copyright (C) 2025 Yusuke Watanabe (ywatanabe@alumni.u-tokyo.ac.jp)

;; Ensure ehf-variables is loaded so ehf-exclude-files is defined
(require 'ehf-variables)

;; Helper function to save the exclusion list

(defun --ehf-registry-save-exclusions ()
  "Save the current state of `ehf-exclude-files` persistently."
  ;; Use customize-save-variable to leverage Emacs' customization persistence
  (customize-save-variable 'ehf-exclude-files ehf-exclude-files)
  ;; Optional: Provide feedback that the list was saved
  ;; (message "Exclusion list saved.")
  )

;; Exclusion Functions
;; ----------------------------------------

(defun ehf-register-exclude-file ()
  "Add current buffer file or marked files in dired to `ehf-exclude-files` and save."
  (interactive)
  (let ((changed nil))
    (if (derived-mode-p 'dired-mode)
        (dolist (file (dired-get-marked-files))
          (let ((expanded-file (expand-file-name file)))
            (unless (member expanded-file ehf-exclude-files)
              (add-to-list 'ehf-exclude-files expanded-file)
              (message "Added %s to exclusion list" file)
              (setq changed t))))
      (if buffer-file-name
          (let ((expanded-file (expand-file-name buffer-file-name)))
            (unless (member expanded-file ehf-exclude-files)
              (add-to-list 'ehf-exclude-files expanded-file)
              (message "Added %s to exclusion list" buffer-file-name)
              (setq changed t)))
        (message "No file to register")))
    ;; Save if changes were made
    (when changed
      (--ehf-registry-save-exclusions))))

(defun ehf-unregister-exclude-file ()
  "Remove current buffer file or marked files in dired from `ehf-exclude-files` and save."
  (interactive)
  (let ((changed nil))
    (if (derived-mode-p 'dired-mode)
        (dolist (file (dired-get-marked-files))
          (let ((expanded-file (expand-file-name file)))
            (when (member expanded-file ehf-exclude-files)
              (setq ehf-exclude-files
                    (delete expanded-file ehf-exclude-files))
              (message "Removed %s from exclusion list" file)
              (setq changed t))))
      (if buffer-file-name
          (let ((expanded-file (expand-file-name buffer-file-name)))
            (when (member expanded-file ehf-exclude-files)
              (setq ehf-exclude-files
                    (delete expanded-file ehf-exclude-files))
              (message "Removed %s from exclusion list"
                       buffer-file-name)
              (setq changed t)))
        (message "No file to unregister")))
    ;; Save if changes were made
    (when changed
      (--ehf-registry-save-exclusions))))

(defun ehf-toggle-exclude-file ()
  "Toggle current buffer file or marked files in dired in `ehf-exclude-files` and save."
  (interactive)
  (let ((changed nil))
    (if (derived-mode-p 'dired-mode)
        (dolist (file (dired-get-marked-files))
          (let ((expanded-file (expand-file-name file)))
            (if (member expanded-file ehf-exclude-files)
                (progn
                  (setq ehf-exclude-files
                        (delete expanded-file ehf-exclude-files))
                  (message "Removed %s from exclusion list" file))
              (add-to-list 'ehf-exclude-files expanded-file)
              (message "Added %s to exclusion list" file))
            (setq changed t)))
                                        ; Change occurred in either case
      (if buffer-file-name
          (let ((expanded-file (expand-file-name buffer-file-name)))
            (if (member expanded-file ehf-exclude-files)
                (progn
                  (setq ehf-exclude-files
                        (delete expanded-file ehf-exclude-files))
                  (message "Removed %s from exclusion list"
                           buffer-file-name))
              (add-to-list 'ehf-exclude-files expanded-file)
              (message "Added %s to exclusion list" buffer-file-name))
            (setq changed t))
                                        ; Change occurred in either case
        (message "No file to toggle")))
    ;; Save if changes were made
    (when changed
      (--ehf-registry-save-exclusions))))

;; Key Bindings (Example - uncomment if desired)
;; ----------------------------------------
;; (global-set-key (kbd "C-c <delete>") 'ehf-toggle-exclude-file)

(provide 'ehf-registry)

(when
    (not load-file-name)
  (message "ehf-registry.el loaded."
           (file-name-nondirectory
            (or load-file-name buffer-file-name))))