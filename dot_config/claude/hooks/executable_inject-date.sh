#!/bin/bash
set -euo pipefail

# PreToolUse hook: inject the current wall-clock time into Claude's context
# via hookSpecificOutput.additionalContext. `permissionDecision` is omitted
# so existing permission rules in settings.json are not affected.

CURRENT_TIME=$(date '+%Y-%m-%d %H:%M:%S %Z')

jq -n --arg context "Current time: ${CURRENT_TIME}" '{
  hookSpecificOutput: {
    hookEventName: "PreToolUse",
    additionalContext: $context
  }
}'
