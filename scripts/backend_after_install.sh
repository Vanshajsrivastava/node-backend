#!/bin/bash
set -euo pipefail

cd /opt/backend
if [ -f package-lock.json ]; then
  npm ci --omit=dev
else
  npm install --omit=dev
fi
