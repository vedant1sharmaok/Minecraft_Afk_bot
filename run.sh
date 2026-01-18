#!/bin/bash
set -e

while true; do
  echo "[BOT] Starting Minecraft client"
  java -Xms512M -Xmx1024M \
    -Djava.awt.headless=true \
    -jar fabric-installer.jar client \
    -dir minecraft || true

  echo "[BOT] Crashed. Restarting in 10s"
  sleep 10
done
