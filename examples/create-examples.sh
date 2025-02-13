#!/bin/bash
# -*- coding: utf-8 -*-
# Timestamp: "2025-02-14 07:05:08 (ywatanabe)"
# File: /home/ywatanabe/.emacs.d/lisp/emacs-header-footer/examples/create-examples.sh

THIS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LOG_PATH="$0.log"
touch "$LOG_PATH"

mkdir -p examples

for ext in el md org py sh tex yaml; do
    filepath="./examples/example.$ext"
    echo "(FILE CONTENTS HERE)" > $filepath
done

# EOF