---
allowed-tools: Bash(git add:*), Bash(git status:*), Bash(git commit:*), Bash(git diff:*), Bash(git log:*)
description: Analyze changes and create a commit with an appropriate one-line message
---

## Context

- Current git status: !`git status`
- Staged changes: !`git diff --no-ext-diff --staged`
- Unstaged changes: !`git diff --no-ext-diff`
- Recent commit messages (for style reference): !`git log --oneline -5`

## Your task

Analyze the current changes and create a git commit with an appropriate one-line message.

Steps:
1. Review the staged and unstaged changes above
2. Stage all relevant modified and new files
3. Generate a concise, descriptive commit message that:
   - Summarizes the nature of the changes (add, update, fix, refactor, etc.)
   - Focuses on "what" and "why", not "how"
   - Follows the style of recent commits in this repository
   - Is one line, under 72 characters
4. Create the commit with the generated message
5. Do NOT push to remote
6. Report the commit hash and message when done
