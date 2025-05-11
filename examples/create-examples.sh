#!/bin/bash
# -*- coding: utf-8 -*-
# Timestamp: "2025-05-11 15:25:43 (ywatanabe)"
# File: ./examples/create-examples.sh

THIS_DIR="$(cd $(dirname ${BASH_SOURCE[0]}) && pwd)"
LOG_PATH="$THIS_DIR/.$(basename $0).log"
echo > "$LOG_PATH"

GREEN='\033[0;32m'
YELLOW='\033[0;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color
# ---------------------------------------

# Create basic directory structure if it doesn't exist
mkdir -p "$THIS_DIR/core"
mkdir -p "$THIS_DIR/registry"
mkdir -p "$THIS_DIR/update"
mkdir -p "$THIS_DIR/languages"
mkdir -p "$THIS_DIR/integration"

# Create example files for each language type
EXT_TYPES=(
  "el:Elisp file content"
  "md:Markdown content"
  "org:Org-mode content"
  "py:Python content"
  "sh:Shell script content"
  "bash:Bash script content"
  "src:Source file content"
  "tex:TeX document content"
  "latex:LaTeX document content"
  "yaml:YAML content"
  "yml:YAML (YML format) content"
)

# Create flat examples for each extension in the root examples directory
echo -e "${GREEN}Creating flat example files in root directory...${NC}"
for ext_info in "${EXT_TYPES[@]}"; do
  ext="${ext_info%%:*}"
  content="${ext_info#*:}"
  filepath="$THIS_DIR/example.$ext"
  
  # Add content based on the file type
  case "$ext" in
    el)
      echo ";;; -*- coding: utf-8; lexical-binding: t -*-" > "$filepath"
      echo ";;; Author: ywatanabe" >> "$filepath"
      echo ";;; Timestamp: <$(date +"%Y-%m-%d %H:%M:%S")>" >> "$filepath"
      echo ";;; File: $filepath" >> "$filepath"
      echo "" >> "$filepath"
      echo ";;; Commentary:" >> "$filepath"
      echo ";; Example elisp file for emacs-header-footer-manager" >> "$filepath"
      echo "" >> "$filepath"
      echo ";;; Code:" >> "$filepath"
      echo "" >> "$filepath"
      echo "(defun example-function ()" >> "$filepath"
      echo "  \"This is an example function.\"" >> "$filepath"
      echo "  (message \"Hello from emacs-header-footer-manager example!\"))" >> "$filepath"
      echo "" >> "$filepath"
      echo "(provide 'example)" >> "$filepath"
      echo "" >> "$filepath"
      echo ";;; example.el ends here" >> "$filepath"
      ;;
    py)
      echo "#!/usr/bin/env python3" > "$filepath"
      echo "# -*- coding: utf-8 -*-" >> "$filepath"
      echo "# Timestamp: \"$(date +"%Y-%m-%d %H:%M:%S") (ywatanabe)\"" >> "$filepath"
      echo "# File: $filepath" >> "$filepath"
      echo "" >> "$filepath"
      echo "def example_function():" >> "$filepath"
      echo "    \"\"\"Example function for emacs-header-footer-manager.\"\"\"" >> "$filepath"
      echo "    print(\"Hello from emacs-header-footer-manager example!\")" >> "$filepath"
      echo "" >> "$filepath"
      echo "if __name__ == \"__main__\":" >> "$filepath"
      echo "    example_function()" >> "$filepath"
      echo "" >> "$filepath"
      echo "# EOF" >> "$filepath"
      ;;
    sh|bash|src)
      echo "#!/bin/bash" > "$filepath"
      echo "# -*- coding: utf-8 -*-" >> "$filepath"
      echo "# Timestamp: \"$(date +"%Y-%m-%d %H:%M:%S") (ywatanabe)\"" >> "$filepath"
      echo "# File: $filepath" >> "$filepath"
      echo "" >> "$filepath"
      echo "THIS_DIR=\"\$(cd \$(dirname \${BASH_SOURCE[0]}) && pwd)\"" >> "$filepath"
      echo "LOG_PATH=\"\$THIS_DIR/.\$(basename \$0).log\"" >> "$filepath"
      echo "echo > \"\$LOG_PATH\"" >> "$filepath"
      echo "" >> "$filepath"
      echo "# Example function" >> "$filepath"
      echo "example_function() {" >> "$filepath"
      echo "  echo \"Hello from emacs-header-footer-manager example!\"" >> "$filepath"
      echo "}" >> "$filepath"
      echo "" >> "$filepath"
      echo "# Call the function" >> "$filepath"
      echo "example_function" >> "$filepath"
      echo "" >> "$filepath"
      echo "# EOF" >> "$filepath"
      ;;
    md)
      echo "<!-- ---" > "$filepath"
      echo "!-- Timestamp: $(date +"%Y-%m-%d %H:%M:%S")" >> "$filepath"
      echo "!-- Author: ywatanabe" >> "$filepath"
      echo "!-- File: $filepath" >> "$filepath"
      echo "!-- --- -->" >> "$filepath"
      echo "" >> "$filepath"
      echo "# Example Markdown File" >> "$filepath"
      echo "" >> "$filepath"
      echo "This is an example markdown file for emacs-header-footer-manager." >> "$filepath"
      echo "" >> "$filepath"
      echo "## Features" >> "$filepath"
      echo "" >> "$filepath"
      echo "- Automatic header management" >> "$filepath"
      echo "- Timestamp updates" >> "$filepath"
      echo "- File path in header" >> "$filepath"
      echo "" >> "$filepath"
      echo "<!-- EOF -->" >> "$filepath"
      ;;
    org)
      echo "#+TITLE: Example Org-mode File" > "$filepath"
      echo "#+AUTHOR: ywatanabe" >> "$filepath"
      echo "#+DATE: $(date +"%Y-%m-%d")" >> "$filepath"
      echo "#+TIMESTAMP: $(date +"%Y-%m-%d %H:%M:%S")" >> "$filepath"
      echo "#+FILE: $filepath" >> "$filepath"
      echo "" >> "$filepath"
      echo "* Example Org File" >> "$filepath"
      echo "" >> "$filepath"
      echo "This is an example Org-mode file for emacs-header-footer-manager." >> "$filepath"
      echo "" >> "$filepath"
      echo "** Features" >> "$filepath"
      echo "" >> "$filepath"
      echo "- Automatic header management" >> "$filepath"
      echo "- Timestamp updates" >> "$filepath"
      echo "- File path in header" >> "$filepath"
      echo "" >> "$filepath"
      echo "#+EOF:" >> "$filepath"
      ;;
    tex|latex)
      echo "%%%% -*- coding: utf-8 -*-" > "$filepath"
      echo "%%%% Timestamp: \"$(date +"%Y-%m-%d %H:%M:%S") (ywatanabe)\"" >> "$filepath"
      echo "%%%% File: \"$filepath\"" >> "$filepath"
      echo "" >> "$filepath"
      echo "\\documentclass{article}" >> "$filepath"
      echo "\\title{Example $ext Document}" >> "$filepath"
      echo "\\author{ywatanabe}" >> "$filepath"
      echo "\\date{\\today}" >> "$filepath"
      echo "" >> "$filepath"
      echo "\\begin{document}" >> "$filepath"
      echo "" >> "$filepath"
      echo "\\maketitle" >> "$filepath"
      echo "" >> "$filepath"
      echo "This is an example $ext document for emacs-header-footer-manager." >> "$filepath"
      echo "" >> "$filepath"
      echo "\\section{Features}" >> "$filepath"
      echo "\\begin{itemize}" >> "$filepath"
      echo "  \\item Automatic header management" >> "$filepath"
      echo "  \\item Timestamp updates" >> "$filepath"
      echo "  \\item File path in header" >> "$filepath"
      echo "\\end{itemize}" >> "$filepath"
      echo "" >> "$filepath"
      echo "\\end{document}" >> "$filepath"
      echo "" >> "$filepath"
      echo "%%%% EOF" >> "$filepath"
      ;;
    yaml|yml)
      echo "# -*- coding: utf-8 -*-" > "$filepath"
      echo "# Timestamp: \"$(date +"%Y-%m-%d %H:%M:%S") (ywatanabe)\"" >> "$filepath"
      echo "# File: $filepath" >> "$filepath"
      echo "" >> "$filepath"
      echo "# Example YAML configuration" >> "$filepath"
      echo "name: emacs-header-footer-manager" >> "$filepath"
      echo "version: 1.0.0" >> "$filepath"
      echo "author: ywatanabe" >> "$filepath"
      echo "" >> "$filepath"
      echo "features:" >> "$filepath"
      echo "  - header_management: true" >> "$filepath"
      echo "  - timestamp_updates: true" >> "$filepath"
      echo "  - file_path_in_header: true" >> "$filepath"
      echo "" >> "$filepath"
      echo "# EOF" >> "$filepath"
      ;;
    *)
      echo "# Example file for $ext" > "$filepath"
      echo "# This is a placeholder content." >> "$filepath"
      ;;
  esac
  
  echo -e "${GREEN}Created:${NC} $filepath"
done

echo -e "\n${GREEN}All example files created successfully!${NC}"
echo -e "${YELLOW}Note:${NC} Elisp examples can be found in the subdirectories:"
echo "  - core/ - Base functionality examples"
echo "  - registry/ - Registry and routing examples"
echo "  - update/ - Update functionality examples"
echo "  - languages/ - Language-specific examples"
echo "  - integration/ - Dired and hook integration examples"

# EOF