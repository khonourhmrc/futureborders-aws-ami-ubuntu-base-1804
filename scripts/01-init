#!/bin/bash
set -uex

FILES=/tmp/files

set +x
cat <<EOF>/usr/local/bin/cloud-init-wait
#!/bin/bash
 # wait for cloud init to finish so it does not clobber apt-get
while ! grep "Cloud-init .* finished" /var/log/cloud-init.log; do
    echo "$(date -Ins) Waiting for cloud-init to finish"
    sleep 2
done
EOF
chmod +x /usr/local/bin/cloud-init-wait
/usr/local/bin/cloud-init-wait
set -uex

# Locale is GB
sed -i  '/ - locale/d' /etc/cloud/cloud.cfg
locale-gen en_GB.utf8 en_GB
localectl set-locale LANG="en_GB.utf8"
update-locale
cat > /etc/default/locale <<EOF
LANG="en_GB.UTF-8"
LANGUAGE="en_GB"
EOF

#Base setup

# Keep our version of modified config files
# cat <<EOF > /etc/apt/apt.conf.d/local
# Dpkg::Options {
#    "--force-confdef";
#    "--force-confold";
# }
# EOF

# disable automatic updates
sed -i 's/Update-Package-Lists "1"/Update-Package-Lists "0"/g' /etc/apt/apt.conf.d/20auto-upgrades
sed -i 's/Unattended-Upgrade "1"/Unattended-Upgrade "0"/g' /etc/apt/apt.conf.d/20auto-upgrades

systemctl stop apt-daily.timer
systemctl stop apt-daily.service
systemctl kill --kill-who=all apt-daily.service
# wait until `apt-get updated` has been killed
while ! (systemctl list-units --all apt-daily.service | grep -f -q dead )
do
	sleep 1;
done

systemctl disable apt-daily.timer
systemctl mask apt-daily.service
systemctl mask apt-daily.timer
systemctl daemon-reload

apt-get update
#Prevent debconf: unable to initialize frontend errors
echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
apt-get -y dist-upgrade

apt-get remove -y openjdk-11-jre-headless

apt-get install -y \
    python \
    python-pip \
    python3 \
    python3-pip \
    virtualenv

# pip2 install --force-reinstall -U pip
pip2 install --no-cache-dir boto3 botocore

pip3 install --no-cache-dir --force-reinstall -U pip
# temp fix for broken import for more info see here
# https://github.com/pypa/pip/issues/5221#issuecomment-381568428
hash -d pip3
pip3 install --no-cache-dir boto3 botocore awscli envtpl

# install certificates.
# install --owner root --group root --mode 0644 \
#         $FILES/certs/*.crt /usr/local/share/ca-certificates/
# /usr/sbin/update-ca-certificates --verbose --fresh

# Create the certificates bundle:
# download current certificates bundle from mkcert.org, then append HMRC CAs.
# BUNDLE_FILE='certs.bundle'
# curl -o /etc/ssl/${BUNDLE_FILE} 'https://mkcert.org/generate/'
# for c in ddcops-production ddcops-production-2 ddcops-staging mdtp; do
#     cat /etc/ssl/certs/${c}.pem >> /etc/ssl/${BUNDLE_FILE}
# done

# chmod 0444 /etc/ssl/${BUNDLE_FILE}
# chown root:root /etc/ssl/${BUNDLE_FILE}

# systtat includes iostat among other things
# trace-cmd includes ftrace
# linux-tools-common includes perf see https://github.com/brendangregg/perf-tools#prerequisites
# linux-tools-generic includes dependencies for perf
# Be nice to your local WebOps
apt-get -y install \
    iftop          \
    htop           \
    netcat         \
    vim            \
    haveged        \
    curl           \
    dstat          \
    sysstat        \
    iotop          \
    strace         \
    tcpdump        \
    trace-cmd      \
    linux-tools-common \
    linux-tools-generic \
    tmux \
    tree \
    jq 

# Disable apt-daily
systemctl disable apt-daily.service
systemctl disable apt-daily.timer
systemctl mask apt-daily.service

# Update system limits
echo '* soft nofile 10000' >> /etc/security/limits.conf
echo '* hard nofile 100000' >> /etc/security/limits.conf

# Add systemd units
for systemd_unit in aws_environment.service aws_tags.service aws.target ready.target; do
    install --owner root --group root --mode 0644 \
        $FILES/systemd/$systemd_unit /etc/systemd/system/$systemd_unit
    systemctl enable $systemd_unit
done
ln -sf /etc/systemd/system/ready.target /etc/systemd/system/default.target

# Create a collectd group
groupadd --system collectd