# encoding: utf-8
# copyright: 2018, The Authors

title 'Load CIS controls'

include_controls 'cis-dil-benchmark' do
  skip_control 'cis-dil-benchmark-1.1.1.6'  # squashfs is not installed, false positive
  skip_control 'cis-dil-benchmark-1.1.11'   # no separate /var/tmp partition, false positive
  skip_control 'cis-dil-benchmark-1.1.12'   # no separate /var/tmp partition, false positive
  skip_control 'cis-dil-benchmark-1.1.13'   # no separate /var/tmp partition, false positive
  skip_control 'cis-dil-benchmark-1.1.14'   # no separate /var/tmp partition, false positive
  skip_control 'cis-dil-benchmark-1.3.1'    # aide is not something we currently have scope to implement properly
  skip_control 'cis-dil-benchmark-1.3.2'    # aide is not something we currently have scope to implement properly
  skip_control 'cis-dil-benchmark-1.4.1'    # no grub conf file, false positive
  skip_control 'cis-dil-benchmark-1.4.2'    # setting bootloader password make VMs unusable in cloud environment
  skip_control 'cis-dil-benchmark-1.4.3'    # single user mode not an issue in cloud environment
  skip_control 'cis-dil-benchmark-1.7.1.4'  # motd does not exist
  skip_control 'cis-dil-benchmark-2.2.1.1'  # using timesyncd instead of ntp
  skip_control 'cis-dil-benchmark-2.2.16'   # rsync not installed # using timesyncd instead of ntp
  skip_control 'cis-dil-benchmark-2.2.1.1'  # using timesyncd instead of ntp
  skip_control 'cis-dil-benchmark-3.4.1'    # tcp wrappers not implemented
  skip_control 'cis-dil-benchmark-3.4.2'    # using AWS security groups in lieu of hosts.allow/deny   
  skip_control 'cis-dil-benchmark-3.4.3'    # using AWS security groups in lieu of hosts.allow/deny
  skip_control 'cis-dil-benchmark-3.6.1'    # using AWS security groups in lieu of instance-based firewalls
  skip_control 'cis-dil-benchmark-3.6.2'    # using AWS security groups in lieu of instance-based firewalls
  skip_control 'cis-dil-benchmark-3.6.3'    # using AWS security groups in lieu of instance-based firewalls
  skip_control 'cis-dil-benchmark-3.6.4'    # using AWS security groups in lieu of instance-based firewalls
  skip_control 'cis-dil-benchmark-3.6.5'    # using AWS security groups in lieu of instance-based firewalls
  skip_control 'cis-dil-benchmark-4.2.1.4'  # using logstash instead of rsyslog
  skip_control 'cis-dil-benchmark-4.2.4'    # breaks some applications
  skip_control 'cis-dil-benchmark-5.2.14'   # only allowed ssh users are installed on VM
  skip_control 'cis-dil-benchmark-5.3.1'    # issues to do with regex being too simplistic to evauluate complex brack syntax
  skip_control 'cis-dil-benchmark-5.3.2'    # issues to do with regex being too simplistic to evauluate complex brack syntax
  skip_control 'cis-dil-benchmark-5.3.3'    # issues to do with regex being too simplistic to evauluate complex brack syntax
  skip_control 'cis-dil-benchmark-5.3.4'    # issues to do with regex being too simplistic to evauluate complex brack syntax
  skip_control 'cis-dil-benchmark-5.2.15'   # allow/deny users not implemented
  skip_control 'cis-dil-benchmark-6.1.6'    # OS is resetting file permissions at boot
  skip_control 'cis-dil-benchmark-6.1.7'    # OS is resetting file permissions at boot
  skip_control 'cis-dil-benchmark-6.1.8'    # OS is resetting file permissions at boot
  skip_control 'cis-dil-benchmark-6.1.9'    # OS is resetting file permissions at boot
  skip_control 'cis-dil-benchmark-6.1.10'   # collectd files are world writeable, need to provide fix that does not break tool
end
