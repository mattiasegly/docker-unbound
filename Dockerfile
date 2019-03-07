FROM balenalib/rpi:buster

RUN [ "cross-build-start" ]

RUN apt-get update && apt-get install -y --no-install-recommends \
	ca-certificates \
	unbound \
&& rm -rf /var/lib/apt/lists/*

COPY entrypoint.sh /usr/local/bin
RUN chmod +x /usr/local/bin/entrypoint.sh

RUN [ "cross-build-end" ]

VOLUME /etc/unbound
EXPOSE 53/tcp 53/udp

ENTRYPOINT ["entrypoint.sh"]
CMD ["unbound"]
