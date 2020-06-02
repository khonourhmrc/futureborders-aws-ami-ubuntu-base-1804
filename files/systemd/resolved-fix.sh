#!/bin/bash

if [ -f /run/cloud-init/instance-data.json ]
then
        hostname=$(cat /run/cloud-init/instance-data.json  | jq -r '.v1."local-hostname"')
        search_path_with_hostname=$(cat /run/cloud-init/instance-data.json  | jq -r '.ds."meta_data"."hostname"')
        if [ -n $search_path_with_hostname ]; then
           search_path_with_hostname=$(cat /run/cloud-init/instance-data.json  | jq -r '.ds."meta-data"."hostname"')
        fi
        search_domains=$(echo "$search_path_with_hostname" | awk -F"${hostname}." '{print $2}')
        echo "CUSTOM_DOMAINS='$search_domains'"
        export CUSTOM_DOMAINS="$search_domains"

        envtpl -o /etc/systemd/resolved.conf --keep-template /etc/systemd/resolved.conf.tpl

fi

