#!/bin/bash
counter=0
while ! systemctl status ready.target --no-pager > /dev/null; do
  echo "Waiting for box to become ready... ${counter}s"
  sleep 10
  counter=$((counter+10))
done
