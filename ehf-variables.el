;;; -*- coding: utf-8; lexical-binding: t -*-
;;; Author: ywatanabe
;;; Timestamp: <2025-11-03 14:45:53>
;;; File: /home/ywatanabe/.emacs.d/lisp/emacs-header-footer-manager/ehf-variables.el

;;; Copyright (C) 2025 Yusuke Watanabe (ywatanabe@scitex.ai)


;; Customization Group
;; ----------------------------------------

(defgroup ehf nil
  "Automatic header and footer management."
  :prefix "ehf-"
  :group 'convenience)

;; (defcustom ehf-exclude-files
;;   '()
;;   "List of files to exclude from header/footer updates."
;;   :type
;;   '(repeat string)
;;   :group 'ehf)

(defcustom ehf-exclude-files
  '("__init__.py")
  "List of files to exclude from header/footer updates."
  :type '(repeat string)
  :group 'ehf)

;; Centralized Whitelist/Blacklist
;; ----------------------------------------

(defcustom ehf-whitelist-expressions
  '()
  "List of regex expressions to whitelist files globally."
  :type '(repeat string)
  :group 'ehf)

(defcustom ehf-blacklist-expressions
  '("__init__.py$" "\\.git/" "/\\.env$" "*sbatch.sh")
  "List of regex expressions to blacklist files globally."
  :type '(repeat string)
  :group 'ehf)

;; Language-specific Whitelist/Blacklist
;; ----------------------------------------

(defcustom ehf-python-whitelist-expressions
  '("\\.py$")
  "List of regex expressions to whitelist Python files."
  :type '(repeat string)
  :group 'ehf)

(defcustom ehf-python-blacklist-expressions
  '("__init__.py$" "__pycache__/" "setup.py$")
  "List of regex expressions to blacklist Python files."
  :type '(repeat string)
  :group 'ehf)

(defcustom ehf-elisp-whitelist-expressions
  '("\\.el$")
  "List of regex expressions to whitelist Elisp files."
  :type '(repeat string)
  :group 'ehf)

(defcustom ehf-elisp-blacklist-expressions
  '()
  "List of regex expressions to blacklist Elisp files."
  :type '(repeat string)
  :group 'ehf)

(defcustom ehf-shell-whitelist-expressions
  '("\\.sh$" "\\.bash$" "sbatch.sh")
  "List of regex expressions to whitelist Shell files."
  :type '(repeat string)
  :group 'ehf)

(defcustom ehf-shell-blacklist-expressions
  '("sbatch.sh")
  "List of regex expressions to blacklist Shell files."
  :type '(repeat string)
  :group 'ehf)

(defcustom ehf-markdown-whitelist-expressions
  '("\\.md$")
  "List of regex expressions to whitelist Markdown files."
  :type '(repeat string)
  :group 'ehf)

(defcustom ehf-markdown-blacklist-expressions
  '()
  "List of regex expressions to blacklist Markdown files."
  :type '(repeat string)
  :group 'ehf)

(defcustom ehf-org-whitelist-expressions
  '("\\.org$")
  "List of regex expressions to whitelist Org files."
  :type '(repeat string)
  :group 'ehf)

(defcustom ehf-org-blacklist-expressions
  '()
  "List of regex expressions to blacklist Org files."
  :type '(repeat string)
  :group 'ehf)

(defcustom ehf-tex-whitelist-expressions
  '("\\.tex$" "\\.latex$")
  "List of regex expressions to whitelist TeX files."
  :type '(repeat string)
  :group 'ehf)

(defcustom ehf-tex-blacklist-expressions
  '()
  "List of regex expressions to blacklist TeX files."
  :type '(repeat string)
  :group 'ehf)

(defcustom ehf-yaml-whitelist-expressions
  '("\\.ya?ml$")
  "List of regex expressions to whitelist YAML files."
  :type '(repeat string)
  :group 'ehf)

(defcustom ehf-yaml-blacklist-expressions
  '()
  "List of regex expressions to blacklist YAML files."
  :type '(repeat string)
  :group 'ehf)

(defcustom ehf-source-whitelist-expressions
  '("\\.src$" "^\\.bashrc$" "^\\.bash_profile$")
  "List of regex expressions to whitelist Source files."
  :type '(repeat string)
  :group 'ehf)

(defcustom ehf-source-blacklist-expressions
  '()
  "List of regex expressions to blacklist Source files."
  :type '(repeat string)
  :group 'ehf)

;; Definitions
;; ----------------------------------------

(defcustom ehf-elisp-extensions
  '("el")
  "List of Elisp file extensions."
  :type
  '(repeat string)
  :group 'ehf)

(defcustom ehf-markdown-extensions
  '("md")
  "List of Markdown file extensions."
  :type
  '(repeat string)
  :group 'ehf)

(defcustom ehf-org-extensions
  '("org")
  "List of Org file extensions."
  :type
  '(repeat string)
  :group 'ehf)

(defcustom ehf-python-extensions
  '("py")
  "List of Python file extensions."
  :type
  '(repeat string)
  :group 'ehf)

(defcustom ehf-shell-extensions
  '("sh" "bash")
  "List of Shell script file extensions."
  :type
  '(repeat string)
  :group 'ehf)

(defcustom ehf-source-extensions
  '("src")
  "List of general source file extensions."
  :type
  '(repeat string)
  :group 'ehf)

(defcustom ehf-source-filenames
  '(".bashrc" "bashrc" ".bash_profile" ".profile" ".zshrc" ".kshrc")
  "List of general source file names."
  :type
  '(repeat string)
  :group 'ehf)

(defcustom ehf-tex-extensions
  '("tex" "latex")
  "List of TeX file extensions."
  :type
  '(repeat string)
  :group 'ehf)

(defcustom ehf-yaml-extensions
  '("yaml" "yml")
  "List of YAML file extensions."
  :type
  '(repeat string)
  :group 'ehf)


(provide 'ehf-variables)

(when
    (not load-file-name)
  (message "ehf-variables.el loaded."
           (file-name-nondirectory
            (or load-file-name buffer-file-name))))