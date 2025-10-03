#!/usr/bin/env bash
set -euo pipefail

# This script delegates to the master install-all.sh in the repo root
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
"$SCRIPT_DIR/../../install-all.sh"
