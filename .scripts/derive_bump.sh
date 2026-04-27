#!/usr/bin/env bash
set -e

TEXT="$1"
LOWER=$(echo "$TEXT" | tr '[:upper:]' '[:lower:]')

if echo "$LOWER" | grep -qE 'breaking|!:|major'; then
  echo "major"
elif echo "$LOWER" | grep -qE 'feat|add|new|glyph'; then
  echo "minor"
else
  echo "patch"
fi
