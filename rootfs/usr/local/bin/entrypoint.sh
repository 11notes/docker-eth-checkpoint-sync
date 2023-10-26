#!/bin/ash
  if [ -z "$1" ]; then
    set -- "checkpointz" \
      --config ${APP_ROOT}/etc/config.yaml
  fi

  exec "$@"