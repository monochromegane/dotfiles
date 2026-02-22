#!/bin/bash
set -euo pipefail

INPUT=$(cat)
FILE_PATH=$(echo "$INPUT" | jq -r '.tool_input.file_path // empty')

if [[ -z "$FILE_PATH" ]] || [[ ! -f "$FILE_PATH" ]]; then
    exit 0
fi

case "${FILE_PATH##*.}" in
    go)
        FMT_OUTPUT=$(gofmt -l -w "$FILE_PATH" 2>&1) || true
        if [[ -n "$FMT_OUTPUT" ]]; then
            echo "go fmt: formatted $FILE_PATH" >&2
        fi

        FILE_DIR=$(dirname "$FILE_PATH")
        if ! VET_OUTPUT=$(cd "$FILE_DIR" && go vet "./..." 2>&1); then
            echo "go vet found issues:" >&2
            echo "$VET_OUTPUT" >&2
            exit 2
        fi
        ;;
    py)
        # Skip if ruff is not installed (install with: uv tool install ruff)
        if ! command -v ruff &>/dev/null; then
            exit 0
        fi

        if ! FMT_OUTPUT=$(ruff format "$FILE_PATH" 2>&1); then
            echo "ruff format failed:" >&2
            echo "$FMT_OUTPUT" >&2
            exit 2
        fi

        if ! LINT_OUTPUT=$(ruff check "$FILE_PATH" 2>&1); then
            echo "ruff check found issues:" >&2
            echo "$LINT_OUTPUT" >&2
            exit 2
        fi
        ;;
    *)
        exit 0
        ;;
esac

exit 0
