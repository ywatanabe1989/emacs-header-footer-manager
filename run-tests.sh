#!/bin/bash
# -*- coding: utf-8 -*-
# Timestamp: "2025-02-21 12:09:26 (ywatanabe)"
# File: /home/ywatanabe/.dotfiles/.emacs.d/lisp/emacs-header-footer/run-tests.sh

THIS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LOG_PATH="$0.log"
touch "$LOG_PATH"

main () {
    emacs -batch -l ert \
          -l package \
          --eval "(progn \
          (package-initialize) \
          (add-to-list 'load-path \".\") \
          (add-to-list 'load-path \"/home/$whoami/.emacs.d/elpa/projectile-20250209.605\") \
          (require 'projectile))" \
          -l ehf-route-ext.el \
          -l ehf-variables.el \
          -l ehf-base.el \
          -l ehf-dired.el \
          -l ehf.el \
          -l ehf-elisp.el \
          -l ehf-markdown.el \
          -l ehf-org.el \
          -l ehf-python.el \
          -l ehf-registry.el \
          -l ehf-shell.el \
          -l ehf-source.el \
          -l ehf-tex.el \
          -l ehf-update-header-and-footer.el \
          -l ehf-yaml.el \
          -l tests/test-ehf-base.el \
          -l tests/test-ehf-dired.el \
          -l tests/test-ehf.el \
          -l tests/test-ehf-elisp.el \
          -l tests/test-ehf-markdown.el \
          -l tests/test-ehf-org.el \
          -l tests/test-ehf-python.el \
          -l tests/test-ehf-registry.el \
          -l tests/test-ehf-shell.el \
          -l tests/test-ehf-source.el \
          -l tests/test-ehf-tex.el \
          -l tests/test-ehf-update-header-and-footer.el \
          -l tests/test-ehf-variables.el \
          -l tests/test-ehf-yaml.el \
          -f ert-run-tests-batch-and-exit
}

main "$@" 2>&1 | tee $LOG_PATH

# EOF