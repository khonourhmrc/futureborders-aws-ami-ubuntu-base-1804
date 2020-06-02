describe service('systemd-timesyncd') do
  it { should be_enabled }
  it { should be_running }
end

describe file('/etc/systemd/timesyncd.conf') do
  its('content') { should include('169.254.169.123') }
end
