#!/bin/bash
set -Eeuo pipefail

echo "[SYSTEM] Starting Baritone AFK bot"

# ---- Java version check ----
JAVA_VER=$(java -version 2>&1 | head -n 1)
if [[ "$JAVA_VER" != *"21"* ]]; then
  echo "[FATAL] Java 21 required"
  echo "$JAVA_VER"
  exit 1
fi

# ---- Health server ----
python3 -m uvicorn health.server:app \
  --host 0.0.0.0 \
  --port 3000 &
  
# ---- Headless display ----
Xvfb :99 -screen 0 1024x768x24 &
export DISPLAY=:99

trap 'echo "[SYSTEM] Shutdown signal received"; exit 0' SIGTERM SIGINT

# ---- Watchdog ----
while true; do
  echo "[BOT] Launching Minecraft 1.21.4 client"
  java -Xms512M -Xmx1024M \
    -Djava.awt.headless=true \
    -Dfml.ignoreInvalidMinecraftCertificates=true \
    -Dfml.ignorePatchDiscrepancies=true \
    -jar fabric-installer.jar client \
    -dir minecraft || true

  echo "[BOT] Client stopped. Restarting in 10s..."
  sleep 10
done
