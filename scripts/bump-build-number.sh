#!/bin/bash
# Increment the build number in an Xcode project's Info.plist or project.pbxproj.
# Usage: ./bump-build-number.sh [project-dir]

set -euo pipefail

PROJECT_DIR="${1:-.}"

PBXPROJ=$(find "$PROJECT_DIR" -name "project.pbxproj" -maxdepth 3 | head -1)

if [ -z "$PBXPROJ" ]; then
  echo "Error: No project.pbxproj found in $PROJECT_DIR" >&2
  exit 1
fi

CURRENT=$(grep -m1 'CURRENT_PROJECT_VERSION' "$PBXPROJ" | grep -oE '[0-9]+' | head -1)
CURRENT=${CURRENT:-0}
NEXT=$((CURRENT + 1))

sed -i '' "s/CURRENT_PROJECT_VERSION = $CURRENT;/CURRENT_PROJECT_VERSION = $NEXT;/g" "$PBXPROJ"

echo "Build number bumped: $CURRENT → $NEXT"
