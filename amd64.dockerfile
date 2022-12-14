# :: Build
	FROM golang:alpine as checkpointz
	ENV checkout=v0.12.0

    RUN set -ex; \
        apk add --update --no-cache \
            nodejs \
            make \
            npm \
            git; \
        git clone https://github.com/ethpandaops/checkpointz.git; \
        cd /go/checkpointz; \
		git checkout ${checkout}; \
        make -j $(nproc); \
        CGO_ENABLED=0 go build -o /usr/local/bin/checkpointz .;


# :: Header
	FROM alpine:latest
	COPY --from=checkpointz /usr/local/bin// /usr/local/bin

# :: Run
	USER root

	# :: prepare
        RUN set -ex; \
            mkdir -p /checkpoint; \
            mkdir -p /checkpoint/etc;

		RUN set -ex; \
			apk add --update --no-cache \
				curl \
				shadow;

		RUN set -ex; \
			addgroup --gid 1000 -S chkpnt; \
			adduser --uid 1000 -D -S -h /checkpoint -s /sbin/nologin -G chkpnt chkpnt;

    # :: copy root filesystem changes
        COPY ./rootfs /

    # :: docker -u 1000:1000 (no root initiative)
        RUN set -ex; \
            chown -R chkpnt:chkpnt \
				/checkpoint

# :: Monitor
    RUN set -ex; chmod +x /usr/local/bin/healthcheck.sh
    HEALTHCHECK CMD /usr/local/bin/healthcheck.sh || exit 1

# :: Start
	RUN set -ex; chmod +x /usr/local/bin/entrypoint.sh
	USER chkpnt
	ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]