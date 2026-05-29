#!/bin/bash
# Generate a JWT for App Store Connect API authentication.
# Requires: openssl, base64, and the following environment variables:
#   APP_STORE_CONNECT_KEY_ID    — API Key ID
#   APP_STORE_CONNECT_ISSUER_ID — Issuer ID
#   APP_STORE_CONNECT_KEY_PATH  — Path to the .p8 private key file

set -euo pipefail

: "${APP_STORE_CONNECT_KEY_ID:?Set APP_STORE_CONNECT_KEY_ID}"
: "${APP_STORE_CONNECT_ISSUER_ID:?Set APP_STORE_CONNECT_ISSUER_ID}"
: "${APP_STORE_CONNECT_KEY_PATH:?Set APP_STORE_CONNECT_KEY_PATH}"

if [ ! -f "$APP_STORE_CONNECT_KEY_PATH" ]; then
  echo "Error: Key file not found at $APP_STORE_CONNECT_KEY_PATH" >&2
  exit 1
fi

NOW=$(date +%s)
EXP=$((NOW + 1200))

b64url() {
  openssl base64 -e -A | tr '+/' '-_' | tr -d '='
}

HEADER=$(printf '{"alg":"ES256","kid":"%s","typ":"JWT"}' "$APP_STORE_CONNECT_KEY_ID" | b64url)
PAYLOAD=$(printf '{"iss":"%s","iat":%d,"exp":%d,"aud":"appstoreconnect-v1"}' \
  "$APP_STORE_CONNECT_ISSUER_ID" "$NOW" "$EXP" | b64url)

SIGNATURE=$(printf '%s.%s' "$HEADER" "$PAYLOAD" | \
  openssl dgst -sha256 -sign "$APP_STORE_CONNECT_KEY_PATH" -binary | b64url)

printf '%s.%s.%s\n' "$HEADER" "$PAYLOAD" "$SIGNATURE"
