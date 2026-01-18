#!/bin/bash
set -Eeuo pipefail

echo "[SYSTEM] Starting services..."

mkdir -p logs

# Start FastAPI health server
uvicorn app.main:app \
  --host 0.0.0.0 \
  --port 8000 \
  >> logs/health.log 2>&1 &

# Headless display
Xvfb :99 -screen 0 1024x768x24 &
export DISPLAY=:99

echo "[SYSTEM] Health server started"
echo "[SYSTEM] Launching Minecraft client watchdog"

# Infinite watchdog loop
while true; do
  echo "[BOT] Starting Minecraft client..."

  java \
    -Xms512M \
    -Xmx1024M \
    -XX:+ExitOnOutOfMemoryError \
    -Djava.awt.headless=true \
    -Dfml.ignoreInvalidMinecraftCertificates=true \
    -Dfml.ignorePatchDiscrepancies=true \
    -jar fabric-installer.jar client \
    -dir runtime \
    >> logs/minecraft.log 2>&1 || true

  echo "[BOT] Client stopped. Restarting in 10 seconds..."
  sleep 10
done
