#!/bin/bash
# -*- coding: utf-8 -*-
# Timestamp: "2025-03-14 13:49:23 (ywatanabe)"
# File: /home/ywatanabe/.emacs.d/lisp/emacs-header-footer/tests/test.sh

THIS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LOG_PATH="$0.log"
touch "$LOG_PATH"


THIS_DIR="$(cd "$(dirname "${BASH_SOURCE[${#BASH_SOURCE[@]} - 1]}")" && pwd)"
LOG_PATH="$0.log"
touch "$LOG_PATH"

# EOF