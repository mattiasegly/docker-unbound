# docker-rpi-unbound
Raspberry Pi Docker Container for Unbound DNS<BR>
The config tries to do DNSSEC and DNS over TLS to Cloudflare, but most values are default.

Run with:<BR>
docker run -d --cap-add=NET_ADMIN -p 53:53/tcp -p 53:53/udp mattiasegly/rpi-unbound

If changes to the config file is necessary, the directory could be mounted by adding:<BR>
--mount type=bind,src=/some/path,dst=/unbound

I know nothing about code, so assume that everything here sets the world on fire.<BR>
Use at your own peril.
