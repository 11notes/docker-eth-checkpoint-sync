#!/bin/ash
  curl --max-time 5 -s http://localhost:9090 || exit 1