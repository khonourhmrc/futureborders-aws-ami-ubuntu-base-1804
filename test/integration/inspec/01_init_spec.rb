describe file('/etc/locale.gen') do
  its('content') { should match (/^en_GB.UTF-8 UTF-8$/) }
end

describe file('/etc/default/locale') do
  its('content') { should match (/LANG="en_GB.UTF-8"/) }
end

# describe file('/etc/apt/apt.conf.d/local') do
#   its('content') { should match (/--force-confdef/) }
#   its('content') { should match (/--force-confold/) }
# end

describe command('locale') do
  its('stdout') { should match (/LANG=en_GB.UTF-8/) }
  its('stdout') { should match (/LANGUAGE=en_GB/) }
end

%w(
  python
  python-pip
  python3
  python3-pip
  virtualenv
  haveged
).each do |package|
  describe package(package) do
    it { should be_installed }
  end
end

%w(
  awscli
  boto3
  botocore
).each do |pkg|
  describe pip(pkg) do
    it { should be_installed }
  end
end

describe command('/usr/bin/pip2 list') do
  its('stdout') { should cmp(/boto3/) }
  its('stdout') { should cmp(/botocore/) }
end

# describe file('/etc/ssl/certs.bundle') do
#   it { should exist }
#   its(:owner) { should eq('root') }
#   its(:group) { should eq('root') }
#   its(:mode) { should cmp('0444') }
# end

# describe command('cat /etc/ssl/certs.bundle | grep  Issuer') do
#   its('stdout') { should match (/Amazon/) }
# end

describe service('apt-daily.timer') do
  it { should_not be_enabled }
end

describe service('apt-daily.service') do
  it { should_not be_enabled }
  it { should_not be_running }
end

describe file('/etc/apt/apt.conf.d/20auto-upgrades') do
  its('content') { should match (/Update-Package-Lists "0"/) }
  its('content') { should match (/Unattended-Upgrade "0"/) }
end

describe service('haveged.service') do
  it { should be_enabled }
  it { should be_running }
end

%w(
  aws_environment.service
  aws_tags.service
  aws.target
  ready.target
).each do |systemd_unit|
  describe file("/etc/systemd/system/#{systemd_unit}") do
    it { should exist }
    its(:owner) { should eq('root') }
    its(:group) { should eq('root') }
    its(:mode) { should cmp('0644') }
  end
end

describe file("/etc/systemd/system/default.target") do
  it { should be_linked_to "/etc/systemd/system/ready.target" }
end

