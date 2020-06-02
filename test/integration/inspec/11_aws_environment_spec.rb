describe command('/bin/systemctl show-environment') do
  its('stdout') { should match(/^AWS_TAG_NAME=test-kitchen-1804-base$/) }
  its('stdout') { should match(/^AWS_DEFAULT_REGION=\w{2}-\w+-\d$/) }
end
