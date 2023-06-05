#!/bin/ash
  if [ -z "$1" ]; then
    set -- "checkpointz" \
      --config /checkpoint/etc/config.yaml
  fi

  exec "$@"