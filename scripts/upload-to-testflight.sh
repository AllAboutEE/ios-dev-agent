#!/bin/bash
# Upload an IPA to App Store Connect / TestFlight using the App Store Connect API.
# Usage: ./upload-to-testflight.sh <path-to-ipa>

set -euo pipefail

IPA_PATH="${1:?Usage: $0 <path-to-ipa>}"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

if [ ! -f "$IPA_PATH" ]; then
  echo "Error: IPA not found at $IPA_PATH" >&2
  exit 1
fi

echo "Uploading $(basename "$IPA_PATH") to App Store Connect..."

if command -v xcrun &>/dev/null; then
  xcrun altool --upload-app \
    -f "$IPA_PATH" \
    -t ios \
    --apiKey "$APP_STORE_CONNECT_KEY_ID" \
    --apiIssuer "$APP_STORE_CONNECT_ISSUER_ID" \
    --show-progress
  echo "Upload complete. Check App Store Connect for processing status."
else
  echo "Error: xcrun not found. Ensure Xcode is installed." >&2
  exit 1
fi
