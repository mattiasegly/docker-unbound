ARG ARCH=
ARG SOURCE_BRANCH=
FROM mattiasegly/base-image:${SOURCE_BRANCH}-${ARCH}

RUN apt-get update && apt-get install -y --no-install-recommends \
	unbound \
&& rm -rf /var/lib/apt/lists/*

COPY entrypoint.sh /usr/local/bin
RUN chmod +x /usr/local/bin/entrypoint.sh

VOLUME /unbound
EXPOSE 53/tcp 53/udp

ENTRYPOINT ["entrypoint.sh"]
CMD ["unbound", "-c", "/unbound/unbound.conf"]
