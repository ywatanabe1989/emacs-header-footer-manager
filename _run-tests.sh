#!/bin/bash
# -*- coding: utf-8 -*-
# Timestamp: "2025-05-09 02:38:01 (ywatanabe)"
# File: /home/ywatanabe/.dotfiles/.emacs.d/lisp/emacs-header-footer/run-tests.sh

THIS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LOG_PATH="$0.log"
touch "$LOG_PATH"

usage() {
    echo "Usage: $0 [-d|--debug] [-s|--single <test-file>] [-h|--help]"
    echo "Runs tests for emacs-header-footer"
    echo
    echo "Options:"
    echo "  -d, --debug    Enable debug output"
    echo "  -s, --single   Run a single test file"
    echo "  -h, --help     Display this help message"
    exit 1
}

run_tests() {
    local debug=$1
    local single_test=$2
    
    local debug_args=""
    local test_files=""
    
    if [[ "$debug" == "true" ]]; then
        debug_args="--eval \"(setq ert-batch-backtrace-right-margin 70)\" --eval \"(setq ert-batch-print-level nil)\" --eval \"(setq ert-batch-print-length nil)\""
    fi
    
    if [[ -n "$single_test" ]]; then
        if [[ ! -f "$single_test" ]]; then
            echo "Error: Test file '$single_test' not found"
            exit 1
        fi
        test_files="-l $single_test"
    else
        test_files="-l tests/test-ehf-base.el \
          -l tests/test-ehf-dired.el \
          -l tests/test-ehf.el \
          -l tests/test-ehf-elisp.el \
          -l tests/test-ehf-markdown.el \
          -l tests/test-ehf-org.el \
          -l tests/test-ehf-python.el \
          -l tests/test-ehf-registry.el \
          -l tests/test-ehf-route-ext.el \
          -l tests/test-ehf-shell.el \
          -l tests/test-ehf-source.el \
          -l tests/test-ehf-tex.el \
          -l tests/test-ehf-update-header-and-footer.el \
          -l tests/test-ehf-variables.el \
          -l tests/test-ehf-yaml.el"
    fi
    
    # shellcheck disable=SC2086
    emacs -batch -l ert \
          -l package \
          --eval "(progn \
          (package-initialize) \
          (add-to-list 'load-path \".\") \
          (add-to-list 'load-path \"~/.emacs.d/elpa/projectile-20250209.605\") \
          (require 'projectile))" \
          -l ehf-utils.el \
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
          ${debug_args} \
          ${test_files} \
          -f ert-run-tests-batch-and-exit
}

main() {
    local debug=false
    local single_test=""
    
    while [[ $# -gt 0 ]]; do
        case $1 in
            -d|--debug) debug=true; shift ;;
            -s|--single) 
                shift
                single_test="$1"
                shift ;;
            -h|--help) usage ;;
            *) echo "Unknown option: $1"; usage ;;
        esac
    done
    
    run_tests "$debug" "$single_test"
}

main "$@" 2>&1 | tee "$LOG_PATH"

# EOF