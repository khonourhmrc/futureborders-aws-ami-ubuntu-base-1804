%w(
  /usr/local/sbin/authorized_keys_command.sh
  /usr/local/sbin/iam_sync.sh
).each do |filename|
  describe file (filename) do
    it { should exist }
    its(:owner) { should eq('root') }
    its(:group) { should eq('root') }
    its(:mode) { should cmp('0755') }
  end
end

describe file ('/etc/cron.d/iam_sync') do
  it { should exist }
  its(:owner) { should eq('root') }
  its(:group) { should eq('root') }
  its(:mode) { should cmp('0644') }
  its(:content) { should match(%r{/usr/local/sbin/iam_sync\.sh}) }
end

# We shouldn't have any non-system users
# Note that the logic in the where statement is quite poorly captured in the
# output. It omits the `not`, for some reason.
control 'Users:' do
  title 'only system users and IAM users should exist.'
  describe users.where { uid >= 1000 and username != "nobody" and not groups.include? "iam-synced-users" }  do
    it { should_not exist }
  end
end
