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
        VET_OUTPUT=$(cd "$FILE_DIR" && go vet "./..." 2>&1) || VET_EXIT=$?

        if [[ -n "${VET_OUTPUT:-}" ]]; then
            echo "go vet found issues:" >&2
            echo "$VET_OUTPUT" >&2
            exit 2
        fi
        ;;
    *)
        exit 0
        ;;
esac

exit 0
