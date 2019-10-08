#!/bin/bash

echo "Update unbound trust anchor..."
unbound-anchor

echo "Write unbound config file if it doesn't exist..."
if [ ! -f /unbound/unbound.conf ]; then
cat > /unbound/unbound.conf << EOF
server:
  do-daemonize: no
  interface: 0.0.0.0
  access-control: 0.0.0.0/0 allow
  do-ip6: no
  ssl-upstream: yes
  ssl-cert-bundle: "/etc/ssl/certs/ca-certificates.crt"
  hide-identity: yes
  hide-version: yes
  hide-trustanchor: yes
  harden-algo-downgrade: yes
  use-caps-for-id: yes
  qname-minimisation-strict: yes
  aggressive-nsec: yes
  prefetch: yes
  prefetch-key: yes
  auto-trust-anchor-file: "/var/lib/unbound/root.key"
#
  private-address: 0.0.0.0/8       # Broadcast address
  private-address: 10.0.0.0/8
  private-address: 100.64.0.0/10
  private-address: 127.0.0.0/8     # Loopback Localhost
  private-address: 169.254.0.0/16
  private-address: 172.16.0.0/12
  private-address: 192.0.0.0/24    # IANA IPv4 special purpose net
  private-address: 192.0.2.0/24    # Documentation network TEST-NET
  private-address: 192.168.0.0/16
  private-address: 198.18.0.0/15   # Used for testing inter-network communications
  private-address: 198.51.100.0/24 # Documentation network TEST-NET-2
  private-address: 203.0.113.0/24  # Documentation network TEST-NET-3
  private-address: 233.252.0.0/24  # Documentation network MCAST-TEST-NET
  private-address: ::1/128         # Loopback Localhost
  private-address: 2001:db8::/32   # Documentation network IPv6
  private-address: fc00::/8        # Unique local address (ULA) part of "fc00::/7", not defined yet
  private-address: fd00::/8        # Unique local address (ULA) part of "fc00::/7", "/48" prefix group
  private-address: fe80::/10       # Link-local address (LLA)
#
forward-zone:
  name: "."
  forward-addr: 1.1.1.1@853
  forward-addr: 1.0.0.1@853
EOF
fi

echo "Check unbound config file..."
unbound-checkconf /unbound/unbound.conf

echo "Overwrite resolv.conf to clear Docker Swarm DNS..."
echo "nameserver 127.0.0.1" > /etc/resolv.conf

echo "Finished! Run container."
exec "$@"
