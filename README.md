# Alpine :: Ethereum Checkpoint Sync
![size](https://img.shields.io/docker/image-size/11notes/eth-checkpoint-sync/0.18.0?color=0eb305) ![version](https://img.shields.io/docker/v/11notes/eth-checkpoint-sync?color=eb7a09) ![pulls](https://img.shields.io/docker/pulls/11notes/eth-checkpoint-sync?color=2b75d6) ![activity](https://img.shields.io/github/commit-activity/m/11notes/docker-eth-checkpoint-sync?color=c91cb8) ![commit-last](https://img.shields.io/github/last-commit/11notes/docker-eth-checkpoint-sync?color=c91cb8)

Run an Ethereum checkpoint sync node based on Alpine Linux. Small, lightweight, secure and fast 🏔️

## Volumes
* **/checkpoint/etc** - Directory of config.yaml

## Run
```shell
docker run --name eth-checkpoint-sync \
  -v ../etc:/checkpoint/etc \
  -d 11notes/eth-checkpoint-sync:[tag]
```

## Defaults
| Parameter | Value | Description |
| --- | --- | --- |
| `user` | docker | user docker |
| `uid` | 1000 | user id 1000 |
| `gid` | 1000 | group id 1000 |
| `home` | /checkpoint | home directory of user docker |

## Built with and thanks to
* [Checkpointz](https://github.com/ethpandaops/checkpointz)
* [Alpine Linux](https://alpinelinux.org/)

## Tipps
* Only use rootless container runtime (podman, rootless docker)
* Don't bind to ports < 1024 (requires root), use NAT/reverse proxy (haproxy, traefik, nginx)
* If you use eth-checkpoint-sync and want to provide states, you need a eth-checkpoint-sync synced from genesis (~5M blocks)!
* Use [telegraf](https://hub.docker.com/r/11notes/telegraf) to export :9090 to [influxdb](https://hub.docker.com/r/11notes/influxdb)