describe package("auditd") do
  it { should be_installed }
end

describe service('auditd') do
  it { should be_enabled }
  it { should be_running }
end

describe file('/etc/auditd/auditd.conf') do
  it { should exist }
  its(:owner) { should eq('root') }
  its(:group) { should eq('root') }
  its(:mode) { should cmp('0644') }
end
