#!/bin/sh
killall -9 cam_app mjpg_streamer 2>/dev/null
sleep 1
ACTION=reload setsid /usr/bin/auto_uvc.sh >/dev/null 2>&1 &

# Wait up to ~10s for a camera process to come back
i=0
while [ $i -lt 10 ]; do
  if pidof mjpg_streamer >/dev/null 2>&1 || pidof cam_app >/dev/null 2>&1; then
    echo "Cameras restarted successfully"
    exit 0
  fi
  sleep 1
  i=$((i + 1))
done

echo "ERROR: Camera restart failed (no camera process running after 10s)"
exit 1
