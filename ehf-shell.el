;;; -*- coding: utf-8; lexical-binding: t -*-
;;; Author: ywatanabe
;;; Timestamp: <2025-11-03 14:45:51>
;;; File: /home/ywatanabe/.emacs.d/lisp/emacs-header-footer-manager/ehf-shell.el

;;; Copyright (C) 2025 Yusuke Watanabe (ywatanabe@scitex.ai)


(require 'ehf-utils)
(require 'ehf-base)

;; Header Variables
;; ----------------------------------------

;; (defcustom --ehf-shell-header-template
;;   "#!/bin/bash
;; # -*- coding: utf-8 -*-
;; # Timestamp: \"%s (%s)\"
;; # File: %s

;; THIS_DIR=\"$(cd \"$(dirname \"${BASH_SOURCE[0]}\")\" && pwd)\"
;; LOG_PATH=\"$THIS_DIR/.\$(basename \"$0\").log\"
;; touch \"$LOG_PATH\" >/dev/null 2>&1
;; "
;;   "Header template for shell script files."
;;   :type 'string
;;   :group 'ehf)

(defcustom --ehf-shell-header-template
  "#!/bin/bash
# -*- coding: utf-8 -*-
# Timestamp: \"%s (%s)\"
# File: %s

ORIG_DIR=\"$(pwd)\"
THIS_DIR=\"$(cd $(dirname ${BASH_SOURCE[0]}) && pwd)\"
LOG_PATH=\"$THIS_DIR/.\$(basename $0).log\"
echo > \"$LOG_PATH\"

GIT_ROOT=\"$(git rev-parse --show-toplevel 2>/dev/null)\"

GRAY='\\033[0;90m'
GREEN='\\033[0;32m'
YELLOW='\\033[0;33m'
RED='\\033[0;31m'
NC='\\033[0m' # No Color

echo_info() { echo -e \"${GRAY}INFO: $1${NC}\"; }
echo_success() { echo -e \"${GREEN}SUCC: $1${NC}\"; }
echo_warning() { echo -e \"${YELLOW}WARN: $1${NC}\"; }
echo_error() { echo -e \"${RED}ERRO: $1${NC}\"; }
echo_header() { echo_info \"=== $1 ===\"; }
# ---------------------------------------"
  "Header template for shell script files."
  :type 'string
  :group 'ehf)

;; BLACK='\\033[0;30m'
;; LIGHT_GRAY='\\033[0;37m'

(defcustom --ehf-shell-header-pattern
  "\\(^#!/bin/bash

# -\\*- coding: utf-8 -\\*-

# Timestamp: \".* (.*)\"

# File: .*

ORIG_DIR=\"$(pwd)\"

THIS_DIR=\"\\$(cd \\$(dirname \\${BASH_SOURCE\\[0\\]}) \\&\\& pwd)\"

LOG_PATH=\"\\$THIS_DIR/.\\$(basename \\$0).log\"

echo > \"\\$LOG_PATH\"

GIT_ROOT=\"$(git rev-parse --show-toplevel 2>/dev/null)\"

BLACK='\\\\033\\[0;30m'

LIGHT_GRAY='\\\\033\\[0;37m'

GRAY='\\\\033\\[0;90m'

GREEN='\\\\033\\[0;32m'

YELLOW='\\\\033\\[0;33m'

RED='\\\\033\\[0;31m'

NC='\\\\033\\[0m' # No Color

echo_info() { echo -e \"${BLACK}INFO: $1${NC}\"; }

echo_info() { echo -e \"${GRAY}INFO: $1${NC}\"; }

echo_success() { echo -e \"${GREEN}SUCC: $1${NC}\"; }

echo_warning() { echo -e \"${YELLOW}WARN: $1${NC}\"; }

echo_error() { echo -e \"${RED}ERRO: $1${NC}\"; }

echo_header() { echo_info \"=== $1 ===\"; }

# ---------------------------------------$\\)"
  "Header pattern for shell script files."
  :type 'string
  :group 'ehf)

;; echo_info() { echo -e \"${LIGHT_GRAY}$1${NC}\"; }

;; echo_success() { echo -e \"${GREEN}$1${NC}\"; }

;; echo_warning() { echo -e \"${YELLOW}$1${NC}\"; }

;; echo_error() { echo -e \"${RED}$1${NC}\"; }

;; Footer Variables
;; ----------------------------------------

(defcustom --ehf-shell-footer-template
  "# EOF"
  "Footer template for shell script files."
  :type 'string
  :group 'ehf)

(defcustom --ehf-shell-footer-pattern
  "\\(^# EOF$\\)"
  "Footer pattern for Shell files."
  :type 'string
  :group 'ehf)

;; Formatters
;; ----------------------------------------

;; (defun --ehf-shell-format-header
;;     (&optional file-path)
;;   "Format Shell header for FILE-PATH or current buffer's file."
;;   (let*
;;       ((path
;;         (or file-path buffer-file-name))
;;        (default-directory
;;         (file-name-directory path))
;;        (git-root
;;         (locate-dominating-file default-directory ".git"))
;;        (git-path
;;         (if git-root
;;             (file-relative-name path git-root)
;;           path))
;;        (git-path-dot
;;         (concat "./" git-path)))
;;     (format --ehf-shell-header-template
;;             (format-time-string "%Y-%m-%d %H:%M:%S")
;;             (user-login-name)
;;             git-path-dot)))

(defun --ehf-shell-format-header
    (&optional file-path)
  "Format Shell header for FILE-PATH or current buffer's file."
  (let*
      ((git-path-dot
        (--ehf-utils-path-to-git-dot-path file-path)))
    (format --ehf-shell-header-template
            (format-time-string "%Y-%m-%d %H:%M:%S")
            (user-login-name)
            git-path-dot)))

(defun --ehf-shell-format-footer
    (&optional file-path)
  "Format Shell footer for FILE-PATH or current buffer's file."
  --ehf-shell-footer-template)

;; (defun --ehf-shell-get-shell-type
;;     (file-path)
;;   "Get shell type from FILE-PATH extension."
;;   (let
;;       ((ext
;;         (file-name-extension file-path)))
;;     (cond
;;      ((equal ext "zsh")
;;       "zsh")
;;      ((equal ext "fish")
;;       "fish")
;;      ((equal ext "ksh")
;;       "ksh")
;;      (t "t"))))

;; Updater
;; ----------------------------------------

;; (defun --ehf-shell-update-header-and-footer
;;     (&optional file-path n-newlines)
;;   "Update header and footer in Shell files."
;;   (let*
;;       ((path
;;         (or file-path buffer-file-name)))
;;     ;; (shell-type
;;     ;;  (--ehf-shell-get-shell-type path)))

;;     (--ehf-base-update-header-and-footer
;;      "sh"
;;      --ehf-shell-header-template
;;      --ehf-shell-header-pattern
;;      #'--ehf-shell-format-header
;;      --ehf-shell-footer-template
;;      --ehf-shell-footer-pattern
;;      #'--ehf-shell-format-footer
;;      file-path
;;      n-newlines)))

(defun --ehf-shell-update-header-and-footer
    (&optional file-path n-newlines)
  "Update header and footer in Shell files."
  (let ((path (or file-path buffer-file-name)))
    (when (--ehf-utils-should-process-file path 'shell)
      (--ehf-base-update-header-and-footer
       "sh" --ehf-shell-header-template --ehf-shell-header-pattern
       #'--ehf-shell-format-header --ehf-shell-footer-template
       --ehf-shell-footer-pattern #'--ehf-shell-format-footer
       file-path n-newlines))))

;; ;; ;; Before Save Hook
;; ;; ;; ----------------------------------------
;; ;; (add-hook 'before-save-hook #'--ehf-shell-update-header-and-footer)


(provide 'ehf-shell)

(when
    (not load-file-name)
  (message "ehf-shell.el loaded."
           (file-name-nondirectory
            (or load-file-name buffer-file-name))))