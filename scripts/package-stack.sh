#!/usr/bin/env bash
set -euo pipefail

if [[ $# -ne 2 ]]; then
  echo "Usage: $0 <stack-dir> <output-zip>" >&2
  exit 1
fi

STACK_DIR="$1"
OUTPUT_ZIP="$2"
OUTPUT_ZIP_ABS="$(realpath -m "$OUTPUT_ZIP")"

if [[ ! -d "$STACK_DIR" ]]; then
  echo "Stack directory not found: $STACK_DIR" >&2
  exit 1
fi

for required in main.tf variables.tf outputs.tf providers.tf versions.tf schema.yaml; do
  if [[ ! -f "$STACK_DIR/$required" ]]; then
    echo "Missing required file: $STACK_DIR/$required" >&2
    exit 1
  fi
done

mkdir -p "$(dirname "$OUTPUT_ZIP_ABS")"
TMP_DIR="$(mktemp -d)"
trap 'rm -rf "$TMP_DIR"' EXIT

cp "$STACK_DIR"/*.tf "$TMP_DIR/"
cp "$STACK_DIR"/*.tftpl "$TMP_DIR/" 2>/dev/null || true
cp "$STACK_DIR"/schema.yaml "$TMP_DIR/"

(
  cd "$TMP_DIR"
  if command -v zip >/dev/null 2>&1; then
    zip -qr "$OUTPUT_ZIP_ABS" .
  else
    python3 -m zipfile -c "$OUTPUT_ZIP_ABS" ./*
  fi
)

echo "Created: $OUTPUT_ZIP_ABS"
