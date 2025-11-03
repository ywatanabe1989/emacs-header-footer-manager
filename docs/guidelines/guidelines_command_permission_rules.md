<!-- ---
!-- Timestamp: 2025-05-12 07:16:13
!-- Author: ywatanabe
!-- File: /home/ywatanabe/.emacs.d/lisp/emacs-header-footer-manager/docs/guidelines/guidelines_command_permission_rules.md
!-- --- -->

## Command Permissions
Please see:
`~/.claude.json`
`PROJECT_ROOT/.claude.local.settings.json`

## Do not create any directory in the root

## `rm` Command
`rm` is not allowed. When you want to `rm /path/to/file.ext`, instead of rm, use `mv` command to `.old` directoryin the directory:
DO NOT: `rm /path/to/file.ext`
DO    : `mkdir -p /path/to/.old && mv /path/to/file.ext /path/to/.old/file-<timestamp>.ext`

This enables restoration reliably.

## Your Understanding Check
Did you understand the guideline? If yes, please say:
`CLAUDE UNDERSTOOD: ~/.claude/guidelines/guidelines_command_permissions.md`

<!-- EOF -->