#!/usr/bin/env python3
import re
import warnings

import boto3
import botocore
import requests


def get_instance_tags(client, instance_id):
    id_filter = {
        'Name': 'resource-id',
        'Values': [instance_id]
    }
    tag_data = client.describe_tags(Filters=[id_filter])['Tags']
    return {tag['Key']: tag['Value'] for tag in tag_data}


def get_eni_tags(client, instance_id):
    filter = [
        {
            'Name': 'attachment.instance-id',
            'Values': [instance_id]
        },
        {
            'Name': 'tag-key',
            'Values': ["Name"]
        }
    ]
    enis = client.describe_network_interfaces(Filters=filter)['NetworkInterfaces']
    if not enis:
        return {}
    tag_data = enis[0]['TagSet']
    return {tag['Key']: tag['Value'] for tag in tag_data}


def append_tags(prefix, tags, filehandle):
    for tag_key, tag_value in tags.items():
        sanitized_key = re.sub(r'[^A-Za-z0-9]', '_', tag_key).upper()
        environment_variable = "{}_{}={}".format(prefix,
                                                 sanitized_key,
                                                 tag_value)
        filehandle.write(
            'DefaultEnvironment="{}"\n'.format(environment_variable))


def write_global_systemd_environment(client, identity_document):
    path = "/etc/systemd/system.conf.d/aws_environment.conf"
    instance_tags = get_instance_tags(client, identity_document['instanceId'])
    try:
        eni_tags = get_eni_tags(client, identity_document['instanceId'])
    except botocore.exceptions.ClientError:
        warnings.warn("Could not get eni tags. This is expected if your instance doesn't attach a persistent ENI at startup.")
        eni_tags = {}

    with open(path, 'w') as filehandle:
        filehandle.write("[Manager]\n")
        filehandle.write('DefaultEnvironment="AWS_DEFAULT_REGION={}"\n'.format(identity_document['region']))
        if 'availabilityZone' in identity_document:
            filehandle.write('DefaultEnvironment="AWS_AVAILABILITY_ZONE={}"\n'.format(identity_document['availabilityZone']))
        append_tags('AWS_TAG', instance_tags, filehandle)
        append_tags('AWS_TAG_ENI', eni_tags, filehandle)


if __name__ == "__main__":

    identity_document = requests.get("http://169.254.169.254/latest/dynamic/instance-identity/document").json()

    ec2 = boto3.client("ec2", region_name=identity_document['region'])

    write_global_systemd_environment(ec2, identity_document)
