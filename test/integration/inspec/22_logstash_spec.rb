# describe package('logstash') do
#   it { should be_installed }
# end

# describe service('logstash') do
#   it { should be_enabled }
#   it { should be_running }
# end

# %w{ 00_input_base.conf 10_input_files.conf 20_filters.conf 30_output_redis.conf }.each do |logstash_config|
#   describe file("/etc/logstash/conf.d/#{logstash_config}") do
#     it { should exist }
#     its(:owner) { should eq('root') }
#     its(:group) { should eq('root') }
#     its(:mode) { should cmp('0644') }
#   end
# end

# describe file ("/etc/systemd/system/logstash.service.d/override.conf") do
#   it { should exist }
#   its(:owner) { should eq('root') }
#   its(:group) { should eq('root') }
#   its(:mode) { should cmp('0644') }
# end

# describe file ("/etc/logrotate.d/logstash") do
#   it { should_not exist }
# end

# describe file ("/etc/logstash/log4j2.properties") do
#   it { should exist }
#   its('content') { should match /.*\-\%i.log\.gz$/ }
#   its('content') { should match /appender.json_rolling.policies.size.size = 1GB/ }
#   its('content') { should match /appender.rolling.policies.size.size = 1GB/ }
#   its('content') { should match /appender.json_rolling.policies.size.type = SizeBasedTriggeringPolicy/ }
#   its('content') { should match /appender.rolling.policies.size.type = SizeBasedTriggeringPolicy/ }
# end
