#!/bin/bash
set -euo pipefail

cd /opt/backend

if ! command -v pm2 >/dev/null 2>&1; then
  sudo npm install -g pm2
fi

if [ -f ecosystem.config.js ]; then
  pm2 startOrRestart ecosystem.config.js --env "${ENVIRONMENT:-dev}"
elif [ -f dist/server.js ]; then
  pm2 describe backend >/dev/null 2>&1 && pm2 delete backend || true
  pm2 start dist/server.js --name backend
elif [ -f index.js ]; then
  pm2 describe backend >/dev/null 2>&1 && pm2 delete backend || true
  pm2 start index.js --name backend
else
  echo "No backend entrypoint found."
  exit 1
fi

pm2 save
