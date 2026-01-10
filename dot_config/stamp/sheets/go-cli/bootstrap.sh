#!/usr/bin/env sh
set -e

go mod tidy
git init
git add . ":!./$0"
git commit -m "Add project skeleton"
make test

rm -- "$0"
