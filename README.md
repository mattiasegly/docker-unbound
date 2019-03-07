# docker-rpi-unbound
Raspberry Pi Docker Container for Unbound DNS

Run with:
docker run -d --cap-add=NET_ADMIN -p 53:53/tcp -p 53:53/udp rpi-unbound

If changes to the config file is necessary, the directory could be mounted by adding:
--mount type=bind,src=/some/path,dst=/etc/unbound

The config tries to do DNSSEC and DNS over TLS to Cloudflare, and most values are default.

Use at your own peril.
