#!/bin/ash
if [ -z "$1" ]; then
    set -- "checkpointz" \
        --config /checkpointz/etc/config.yaml
fi

exec "$@"