# docker-eth-checkpoint
Provides checkpoint sync for Ethereum consensus clients.

## Volumes
None

## Run
```shell
docker run --name checkpoint \
    -v /.../config.yaml:/checkpoint/etc/config.yaml:ro \
    -d 11notes/checkpoint:[tag]
```

# Examples config.yaml
```shell
...
checkpointz:
  mode: light

beacon:
  upstreams:
  - name: Prysm Consensus Client
    address: http://localhost:3500
    dataProvider: true
...
```

```shell
...
checkpointz:
  # if mode is set to full prysm needs to be synced from genesis
  # NOT from checkpoint sync from another endpoint!
  mode: full

beacon:
  upstreams:
  - name: Prysm Consensus Client (from genesis)
    address: http://localhost:3500
    dataProvider: true
...
```

## Build with
* [samcm/checkpointz](https://github.com/samcm/checkpointz) - An Ethereum beacon chain checkpoint sync provider 
* [Alpine Linux](https://alpinelinux.org/) - Alpine Linux
* [NodeJS](https://nodejs.org/en/) - NodeJS