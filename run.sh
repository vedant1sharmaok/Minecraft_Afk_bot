#!/bin/bash
set -Eeuo pipefail

echo "[SYSTEM] Starting Baritone AFK bot"

# Health server
python3 -m uvicorn health.server:app \
  --host 0.0.0.0 \
  --port 3000 &

# Virtual display
Xvfb :99 -screen 0 1024x768x24 &
export DISPLAY=:99

trap 'echo "[SYSTEM] Shutdown signal received"; exit 0' SIGTERM SIGINT

cd minecraft

while true; do
  echo "[BOT] Launching Minecraft 1.21.4 client"

  java -Xms512M -Xmx1024M \
    -Djava.awt.headless=true \
    -Dfml.ignoreInvalidMinecraftCertificates=true \
    -Dfml.ignorePatchDiscrepancies=true \
    -jar ../fabric-loader-1.21.4.jar || true

  echo "[BOT] Client stopped. Restarting in 10 seconds..."
  sleep 10
done
