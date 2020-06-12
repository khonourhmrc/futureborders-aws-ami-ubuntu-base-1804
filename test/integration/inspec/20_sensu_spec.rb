# describe package("sensu") do
#   it { should be_installed }
# end

# describe service('sensu-client') do
#   it { should be_enabled }
#   it { should be_running }
# end

# describe service('sensu_client_config') do
#   it { should be_enabled }
# end

# # Check if Sensu configs have been created
# %w{ client.json transport.json }.each do |sensu_config|
#   describe file("/etc/sensu/conf.d/#{sensu_config}") do
#     it { should exist }
#     its(:owner) { should eq('sensu') }
#     its(:group) { should eq('sensu') }
#     its(:mode) { should cmp('0644') }
#   end
# end

# describe json('/etc/sensu/conf.d/client.json') do
#   its(%w( client name )) { should match( /\w+_i-\w+/ ) }
#   its(%w( client address )) { should match( /\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}/ ) }
#   its(['client', 'subscriptions', 0]) { should eq 'default_subscription_18_04' }
# end

# %w(
#   config_templates
#   mdtp_scripts
# ).each do |a_dir|
#   describe directory("/usr/share/sensu/#{a_dir}") do
#     it { should exist }
#   end
# end

# %w(
#   check-ntp-offset.sh
# ).each do |script|
#   describe file("/usr/share/sensu/mdtp_scripts/#{script}") do
#     it { should exist }
#     its(:owner) { should eq('sensu') }
#     its(:group) { should eq('sensu') }
#     its(:mode) { should cmp('0755') }
#   end
# end

# describe file('/etc/logrotate.d/sensu') do
#   it { should exist }
#   its(:owner) { should eq('root') }
#   its(:group) { should eq('root') }
#   its(:mode) { should cmp('0644') }
# end

# %w(
#   check-process.rb
#   check-disk-usage.rb
#   check-ports.rb
# ).each do |plugins|
#   describe file("/opt/sensu/embedded/bin/#{plugins}") do
#     it { should exist }
#     its(:owner) { should eq('root') }
#     its(:group) { should eq('root') }
#     its(:mode) { should cmp('0755') }
#   end
# end
