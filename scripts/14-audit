#!/bin/bash
set -uex

FILES=/tmp/files

apt-get -y install auditd

systemctl enable auditd

install -D --owner root --group root --mode 0644 \
    $FILES/auditd/auditd.conf /etc/auditd/auditd.conf