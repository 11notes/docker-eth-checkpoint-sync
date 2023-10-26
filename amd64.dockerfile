# :: Build
  FROM golang:alpine as build
  ENV APP_VERSION=v0.18.0

  RUN set -ex; \
    apk add --update --no-cache \
      nodejs \
      make \
      npm \
      git; \
    apk upgrade; \
    git clone https://github.com/ethpandaops/checkpointz.git; \
    cd /go/checkpointz; \
    git checkout ${APP_VERSION};

  # fix security
  # https://nvd.nist.gov/vuln/detail/CVE-2023-44487⁠
  # https://nvd.nist.gov/vuln/detail/CVE-2023-3978⁠
  # https://nvd.nist.gov/vuln/detail/CVE-2023-39325⁠
  # https://nvd.nist.gov/vuln/detail/CVE-2020-28483⁠
  # https://nvd.nist.gov/vuln/detail/CVE-2023-29401⁠
  # https://nvd.nist.gov/vuln/detail/CVE-2023-26125⁠
  RUN set -ex; \
    sed -i 's#(golang.org/x/net) v0.10.0#$1 v0.17.0#g' /go/checkpointz/go.mod; \
    sed -i 's#(github.com/gin-gonic/gin) v1.7.4#$1 v1.7.7#g' /go/checkpointz/go.mod; \
    cd /go/checkpointz; \
    go mod tidy;

  RUN set -ex; \
    cd /go/checkpointz; \
    make -j $(nproc); \
    CGO_ENABLED=0 go build -o /usr/local/bin/checkpointz .;

# :: Header
  FROM 11notes/alpine:stable
  ENV APP_ROOT="/checkpoint"
  COPY --from=build /usr/local/bin/ /usr/local/bin

# :: Run
  USER root

  # :: prepare image
    RUN set -ex; \
      mkdir -p ${APP_ROOT}; \
      mkdir -p ${APP_ROOT}/etc; \
      apk --no-cache upgrade;

  # :: copy root filesystem changes and add execution rights to init scripts
    COPY ./rootfs /
    RUN set -ex; \
      chmod +x -R /usr/local/bin;

  # :: change home path for existing user and set correct permission
    RUN set -ex; \
      usermod -d ${APP_ROOT} docker; \
      chown -R 1000:1000 \
        ${APP_ROOT};   

# :: Monitor
  HEALTHCHECK CMD /usr/local/bin/healthcheck.sh || exit 1

# :: Start
  USER docker
  ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]