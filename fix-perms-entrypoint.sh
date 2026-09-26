#!/bin/sh
set -e

DATA_DIR="/home/suwayomi/.local/share/Tachidesk"

# A freshly-mounted volume (e.g. Railway's) shadows the world-writable
# directory the base image bakes in at build time, and is typically owned
# by root — the container's non-root "suwayomi" user then can't write to
# it. Fix ownership here (as root, before dropping privileges) instead of
# skipping persistence.
mkdir -p "$DATA_DIR"
chown -R suwayomi:suwayomi "$DATA_DIR"

exec setpriv --reuid=1000 --regid=1000 --init-groups /home/suwayomi/startup_script.sh
