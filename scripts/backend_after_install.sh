#!/bin/bash
set -euo pipefail

sudo chown -R ec2-user:ec2-user /opt/backend
cd /opt/backend
export PATH="/usr/local/bin:/usr/bin:/bin:$PATH"

if [ -f package-lock.json ]; then
  npm ci --omit=dev
else
  npm install --omit=dev
fi
