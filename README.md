# rpi-unbound
Docker container for Unbound DNS.<BR>
Multi-arch build using balena's Raspberry Pi image and docker's official Debian image.

The config tries to do DNSSEC and DNS over TLS to Cloudflare, but most values are default.<BR>
If changes to the config file are necessary, the directory could be mounted by adding:<BR>
--mount type=bind,src=/some/path,dst=/unbound

Run with:<BR>
docker run -d \\\
--cap-add=NET_ADMIN \\\
-p 53:53/tcp \\\
-p 53:53/udp \\\
mattiasegly/rpi-unbound:latest

I know nothing about code, so assume that everything here sets the world on fire.<BR>
Use at your own peril.
