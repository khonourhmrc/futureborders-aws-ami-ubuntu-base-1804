# %w(
#   /usr/local/sbin/authorized_keys_command.sh
#   /usr/local/sbin/iam_sync.sh
# ).each do |filename|
#   describe file (filename) do
#     it { should exist }
#     its(:owner) { should eq('root') }
#     its(:group) { should eq('root') }
#     its(:mode) { should cmp('0755') }
#   end
# end

# We shouldn't have any non-system users
control 'Users:' do
  title 'only system users and IAM users should exist.'
  describe users.where { uid >= 1000 and username != "nobody" and username != "ubuntu" }  do
    it { should_not exist }
  end
end
