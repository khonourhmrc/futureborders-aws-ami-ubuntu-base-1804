#!/bin/bash
set -uex

FILES=/tmp/files

install --owner root --group root --mode 0644  \
    ${FILES}/systemd/journald.conf              \
    /etc/systemd/

systemctl mask systemd-journald-audit.socket

install --owner root --group root --mode 0644 $FILES/systemd/resolved.conf.tpl  /etc/systemd/resolved.conf.tpl
install --owner root --group root --mode 0755 $FILES/systemd/resolved-fix.sh /usr/local/sbin/resolved-fix.sh
install --owner root --group root --mode 0644 ${FILES}/systemd/resolved-fix.service /etc/systemd/system/resolved-fix.service
systemctl enable resolved-fix.service
