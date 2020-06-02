#!/bin/bash

MDTP_COMPONENT=${AWS_TAG_NAME}
MDTP_HOSTNAME=${HOSTNAME}

# If this is a test being run by Jenkins in Management we set collectd to use UDP
# as it will not be able to access the Graphite relay ELB, this ensures that 
# collectdctl based tests continue to work
if [[ "${AWS_TAG_NAME}" =~ ^(packer|test-kitchen) && "${AWS_TAG_ENV}" =~ ^management$ ]]; then
   export COLLECTD_GRAPHITE_PROTOCOL=udp
else
   export COLLECTD_GRAPHITE_PROTOCOL=tcp
fi

export MY_NAME=${MDTP_COMPONENT}-${MDTP_HOSTNAME}

envtpl -o /etc/collectd/collectd.conf \
    --keep-template                   \
    /etc/collectd/collectd.conf.tpl
