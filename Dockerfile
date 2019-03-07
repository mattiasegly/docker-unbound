FROM balenalib/rpi-raspbian:buster

RUN apt-get update && apt-get install -y --no-install-recommends \
	ca-certificates \
  unbound \
&& rm -rf /var/lib/apt/lists/*

COPY entrypoint.sh /usr/local/bin

VOLUME /etc/unbound
EXPOSE 53/tcp 53/udp

ENTRYPOINT ["entrypoint.sh"]
CMD ["unbound"]
