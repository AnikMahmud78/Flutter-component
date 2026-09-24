#!/bin/bash
set -e

echo "Verifying 0 un-tokenized hardcoded values in Dart files..."
if grep -rnw 'lib/' -e 'Color(0xFF'; then
  echo "Error: Found hardcoded raw hex colors! Use md.sys.color tokens."
  exit 1
fi
echo "Linter checks passed successfully."
