#!/bin/bash
# -*- coding: utf-8 -*-
# Timestamp: "2025-02-14 07:20:17 (ywatanabe)"
# File: /home/ywatanabe/.emacs.d/lisp/emacs-header-footer/examples/create-examples.sh

THIS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LOG_PATH="$0.log"
touch "$LOG_PATH"

mkdir -p examples

for ext in el md org py sh tex yaml; do
    filepath="./examples/example.$ext"
    echo "(FILE CONTENTS HERE)" > $filepath
done

# ### Batch Updates (Dired)

# Update multiple files:
# 1. Mark files in dired
# 2. Press `H` or `M-x ehf-dired-do-update-header-footer`

# EOF