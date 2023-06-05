# Info
Provides checkpoint sync for Ethereum consensus clients.

Like a proxy server checkpointz allows others to sync current blocks and states from your consensus clients in a save and secure manner. A list of supported clients and more can be found on the [samcm/checkpointz github](https://github.com/samcm/checkpointz).

This container provides an easy and simple way to use checkpointz without the hassle of library dependencies and compiling the source yourself, and most importantly without the need of a debian based Linux.

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

## Build with
* [samcm/checkpointz](https://github.com/samcm/checkpointz) - An Ethereum beacon chain checkpoint sync provider 
* [Alpine Linux](https://alpinelinux.org/) - Alpine Linux
* [NodeJS](https://nodejs.org/en/) - NodeJS

## Tipps
* Use a webproxy to terminate the SSL connection and proxy to :5555 of this container (like nginx)
* If you use prysm and want to provide states, you need a prysm synced from genesis (~5M blocks)!
* Use [telegraf](https://github.com/influxdata/telegraf) to export :9090 to [influxdb](https://github.com/influxdata/influxdb)