#!/bin/bash
set -e

echo "Configuring repository git hooks..."
git config core.hooksPath .githooks
chmod +x .githooks/pre-commit
echo "Git hooks configured successfully."
