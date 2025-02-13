<!-- ---
!-- Timestamp: 2025-02-14 07:20:06
!-- Author: ywatanabe
!-- File: /home/ywatanabe/.emacs.d/lisp/emacs-header-footer/README.md
!-- --- -->

# Emacs Header Footer Manager (EHF)

[![Build Status](https://github.com/ywatanabe1989/emacs-header-footer-manager/workflows/tests/badge.svg)](https://github.com/ywatanabe1989/emacs-header-footer-manager/actions)

Automatic header and footer management in Emacs.

## Features

- Header/footer management
- Timestamp updates
- File path addition to header (friendly for LLM)
- File exclusion system for update
- Dired integration for batch operations

## Supported Files

- [Elisp (.el)](./examples/example.el?plain=1)
- [Markdown (.md)](./examples/example.md?plain=1)
- [Org (.org)](./examples/example.org?plain=1)
- [Python (.py)](./examples/example.py?plain=1)
- [Shell (.sh)](./examples/example.sh?plain=1)
- [TeX (.tex)](./examples/example.tex?plain=1)
- [YAML (.yaml, .yml)](./examples/example.yaml?plain=1)

## Installation

```elisp
(require 'ehf)
```

## Usage

### Manual Updates

Update current buffer:
```elisp
M-x ehf-update-header-and-footer
```

### Batch Updates (Dired)

Update multiple files:
1. Mark files in dired
2. Press `H` or `M-x ehf-dired-do-update-header-footer`

### File Exclusion

Exclude files from updates:
```elisp
M-x ehf-toggle-exclude-file     ; Toggle current/marked file(s)
M-x ehf-register-exclude-file   ; Add to exclusion list
M-x ehf-unregister-exclude-file ; Remove from list
```

## Configuration

```elisp
;; Optional: Automatic updates on save
(add-hook 'before-save-hook #'ehf-update-header-and-footer)

;; Dired integration
(define-key dired-mode-map (kbd "H") 'ehf-dired-do-update-header-footer)

;; Quick exclusion toggle
(global-set-key (kbd "C-c <delete>") 'ehf-toggle-exclude-file)
```

## TODO
- [ ] html
- [ ] css
- [ ] js
- [ ] ts
- [ ] zsh

## Contact

Yusuke Watanabe (ywatanabe@alumni.u-tokyo.ac.jp)

<!-- EOF -->