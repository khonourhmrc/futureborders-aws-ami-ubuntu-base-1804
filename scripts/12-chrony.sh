#!/bin/bash
set -uex pipefail

# Use amazons internal timeserver as preferable to external, add config to the start of the config file
# remote ntp and config if it exists in favour of chrony.

apt-get autoremove ntp
apt-get purge ntp
apt-get install -y chrony
echo 'server 169.254.169.123 prefer iburst' | cat - /etc/chrony/chrony.conf > temp && mv temp /etc/chrony/chrony.conf
service chrony restart
