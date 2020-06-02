describe package('collectd-core') do
  it { should be_installed }
end

describe package('collectd') do
  it { should be_installed }
  its('version') { should cmp >= '5.8.0' }
end

describe package('sysstat') do
  it { should be_installed }
end

describe service('collectd') do
  it { should be_enabled }
  it { should be_running }
end

describe package('collectd-utils') do
  it { should be_installed }
end

describe service('collectd-pre') do
  it { should be_enabled }
end

describe pip('envtpl') do
  it { should be_installed }
end

describe parse_config_file('/etc/collectd/collectd.conf', assignment_regex: /^(\w+)\s+(\w+)/) do
  its('FQDNLookup') { should eq('false') }
end

describe file ("/etc/collectd/collectd.conf.d/default.conf") do
  it { should exist }
  its(:owner) { should eq('root') }
  its(:group) { should eq('root') }
  its(:mode) { should cmp('0644') }
end

describe file ("/etc/collectd/collectd.conf.d/iostat.conf") do
  it { should exist }
  its(:owner) { should eq('root') }
  its(:group) { should eq('root') }
  its(:mode) { should cmp('0644') }
end

describe file ("/etc/collectd/collectd.conf.d/interface.conf") do
  it { should exist }
  its(:owner) { should eq('root') }
  its(:group) { should eq('root') }
  its(:mode) { should cmp('0644') }
end

describe file ("/usr/share/collectd/mdtp_scripts/iostat.sh") do
  it { should exist }
  its(:owner) { should eq('root') }
  its(:group) { should eq('root') }
  its(:mode) { should cmp('0755') }
end

describe directory("/usr/share/collectd/mdtp_scripts") do
  it { should exist }
end

describe file ("/etc/logrotate.d/collectd") do
  it { should exist }
  its(:owner) { should eq('root') }
  its(:group) { should eq('root') }
  its(:mode) { should cmp('0644') }
end

describe file ("/var/run/collectd-unixsock") do
  it { should exist }
  its(:owner) { should eq('root') }
  its(:group) { should eq('collectd') }
  its(:mode) { should cmp('0660') }
end
