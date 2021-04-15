#!/bin/sh

git diff --diff-filter=d --name-only | grep -e '\.swift$' | while read filename; do
  mint run nicklockwood/SwiftFormat swiftformat "${filename}"
done