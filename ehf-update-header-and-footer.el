;;; -*- coding: utf-8; lexical-binding: t -*-
;;; Author: ywatanabe
;;; Timestamp: <2025-09-02 06:39:11>
;;; File: /home/ywatanabe/.emacs.d/lisp/emacs-header-footer-manager/ehf-update-header-and-footer.el

;;; Copyright (C) 2025 Yusuke Watanabe (ywatanabe@scitex.ai)

(require 'ehf-route-ext)

;; Main Function
;; ----------------------------------------

(defun ehf-update-header-and-footer (&optional file-path n-newlines)
  "Update header and footer for FILE-PATH or current buffer.
Files listed in `ehf-exclude-files' will be skipped."
  (interactive)
  (let ((old-undo-list buffer-undo-list))
    (save-excursion
      (let* ((path (or file-path buffer-file-name)))
        (when (and path
                   (not
                    (member (expand-file-name path) ehf-exclude-files)))
          (let* ((ext (file-name-extension path))
                 (routed-ext (--ehf-route-ext ext)))
            (cond
             ((equal routed-ext "el")
              (--ehf-elisp-update-header-and-footer file-path
                                                    n-newlines))
             ((equal routed-ext "md")
              (--ehf-markdown-update-header-and-footer file-path
                                                       n-newlines))
             ((equal routed-ext "org")
              (--ehf-org-update-header-and-footer file-path n-newlines))
             ((equal routed-ext "py")
              (--ehf-python-update-header-and-footer file-path
                                                     n-newlines))
             ((equal routed-ext "sh")
              (--ehf-shell-update-header-and-footer file-path
                                                    n-newlines))
             ((equal routed-ext "source")
              (--ehf-source-update-header-and-footer file-path
                                                     n-newlines))
             ((equal routed-ext "tex")
              (--ehf-tex-update-header-and-footer file-path n-newlines))
             ((or (equal routed-ext "yaml") (equal routed-ext "yml"))
              (--ehf-yaml-update-header-and-footer file-path
                                                   n-newlines)))))))
    (setq buffer-undo-list old-undo-list)))

;; (de ehf-update-headerd-footer
;;     (&optional file-path n-newlines;   "Update hea and footer for FILE-PAor current buffer.
;; Fs listed in `ehf-exclude-fi' will be skipped."
;;   (interactive)
;;   do-amalgamate-change-group
;;    (let ((ber-undo-list buffundo-list))
;;      (e-excursion
;;        (let*
;;            ((p
;;              (or file-pabuffer-file-name)))
;;          (when
;;           (and path                   (not
;;                 (member
;;                     (expand-file-name path)
;;                  ehf-exclude-files)))
;;            (let*
;;             ((ext
;;                  (file-n-extension path))
;;                 (routed-ext
;;               (--ehf-route-ext ext)))
;;              (cond
;;               ((equaouted-ext "el")
;;                (--ehfisp-update-header-and-footer file-path
;;                                                   n-newlines))
;;               ((el routed-ext "md")
;;                (-f-markdown-update-header-and-footer file-path
;;                                                      n-newlines))
;;              equal routed-ext "org")
;;             (--ehf-org-update-header-and-footer file-path
;;                                                 n-newlines))
;;               ((al routed-ext "py")
;;                (--ehython-update-header-and-footer file-path
;;                                                    n-newlines))
;;               ((equaouted-ext "sh")
;;                (--ehfell-update-header-and-footer file-path
;;                                                   n-newlines))
;;               ((el routed-ext "sourc
;;                (--ehf-source-update-her-and-footer file-path
;;                                                    n-newlines))
;;            ((equal routed-ext "tex")
;;                (--ehf-tex-update-header-anooter file-path
;;                                                    n-newlines))
;;               ((or
;;                 (equal routed-ext "yaml")
;;                 (equal routed-ext "yml"))
;;                (--ehf-yaml-update-header-and-footer file-path
;;                                                     n-newlines))))))))
;;    (setq buffer-undo-list buffer-undo-list)))

;; (defun ehf-update-header-and-footer-external
;;     (file-path &optional n-newlines)
;;   "Update header and footer for external FILE-PATH and save."
;;   (interactive)
;;   (save-excursion
;;     (when
;;         (and file-path
;;              (file-exists-p file-path)
;;              (file-writable-p file-path))
;;       (let*
;;           ((existing-buf
;;             (get-file-buffer file-path))
;;            (buf
;;             (or existing-buf
;;                 (find-file-noselect file-path))))
;;         (with-current-buffer buf
;;           (let
;;               ((buffer-file-name file-path))
;;             (ehf-update-header-and-footer file-path n-newlines)
;;             (save-buffer))
;;           (unless existing-buf
;;             (kill-buffer)))))))

;; Base Functions
;; ----------------------------------------

(defun --ehf-base-update-header-and-footer
    (expected-routed-ext
     header-template
     header-pattern
     header-format-fn
     footer-template
     footer-pattern
     footer-format-fn
     &optional
     file-path
     n-new-lines)
  "Update header and footer using specified templates and formatters."
  (save-excursion
    (let*
        ((buffer-path
          (or file-path buffer-file-name))
         (ext
          (file-name-extension buffer-path))
         (routed-ext
          (--ehf-route-ext ext)))
      (when
          (equal routed-ext expected-routed-ext)
        ;; Insert content
        (--ehf-base-remove-headers header-pattern ext file-path)
        (--ehf-base-insert-header header-template header-format-fn
                                  file-path n-new-lines)
        (--ehf-base-remove-footers footer-pattern ext file-path)
        (--ehf-base-insert-footer footer-format-fn file-path
                                  n-new-lines)
        ;; Mark buffer as modified
        (set-buffer-modified-p t)))))

;; ;; Before Save Hook
;; ;; ----------------------------------------
;; (add-hook 'before-save-hook #'ehf-update-header-and-footer)

(provide 'ehf-update-header-and-footer)

(when
    (not load-file-name)
  (message "ehf-update-header-and-footer.el loaded."
           (file-name-nondirectory
            (or load-file-name buffer-file-name))))
