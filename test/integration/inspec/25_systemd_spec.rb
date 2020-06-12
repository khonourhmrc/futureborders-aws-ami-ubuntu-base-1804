describe file("/etc/systemd/journald.conf") do
  it { should exist }
  its(:owner) { should eq('root') }
  its(:group) { should eq('root') }
  its(:mode) { should cmp('0644') }
  its('content') { should include(%q[Storage=persistent]) }
end

describe file("/etc/systemd/system/systemd-journald-audit.socket") do
  it { should exist }
  it { should be_symlink }
  it { should be_linked_to '/dev/null'}
end

describe file("/usr/local/sbin/resolved-fix.sh") do
  it { should exist }
  its(:owner) { should eq('root') }
  its(:group) { should eq('root') }
  its(:mode) { should cmp('0755') }
end

describe file("/etc/systemd/resolved.conf.tpl") do
  it { should exist }
  its(:owner) { should eq('root') }
  its(:group) { should eq('root') }
  its(:mode) { should cmp('0644') }
end

# describe file("/etc/systemd/resolved.conf") do
#   it { should exist }
#   its('content') { should include(%q[Domains=]) }
#   its('content') { should match(/\w+.mdtp eu-west-2.compute.internal/) }
# end

describe service("resolved-fix") do
  it { should be_enabled }
end
