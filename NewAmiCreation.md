# New AMI creation

Documentation creating a brand new AMI from scratch, intended to explain the various options we use in packer and test-kitchen. For easy new AMI creation you can use [AMI boilerplate generator](https://github.tools.tax.service.gov.uk/HMRC/aws-ami-generator).

## Quick notes

Notes related for quick local packer and test-kitchen setup:

* export ```PACKER_SSH_USER```
* export ```TEST_KITCHEN_USER```
* source env.sh
* specify/export ```TEST_KITCHEN_AMI``` before running ```kitchen``` commands

## Environment aware changes

Each environment had it's default VPC, security groups, subnets deleted, this way we need to specify which ones to use. Jenkins gets it's VPC and a subnet associated to the continuous-integration automatically upon startup, the ```AWS_VPC_ID``` and ```AWS_SUBNET_ID``` are set accordingly and later used in packer and test-kitchen templates. We do the same locally in the ```env.sh``` file.

## Packer template

Packer templates are in the ```templates``` directory as *.json files. First we define the variables:

```json
  "variables": {
    "aws_subnet_id": "{{ env `AWS_SUBNET_ID` }}",
    "aws_vpc_id": "{{ env `AWS_VPC_ID` }}",
    "aws_region": "{{ env `AWS_DEFAULT_REGION` }}",
    "packer_iam_groups": "webops_engineer",
    "packer_ssh_username": "{{ env `PACKER_SSH_USER` }}",
    "packer_ssh_agent_auth": "true",
    "tag_user": "{{ env `USER` }}",
    "tag_build_url": "{{ env `BUILD_URL` }}",
    "tag_build_tag": "{{ env `BUILD_TAG` }}"
  }
```
* ```aws_subnet_id```: Assigned when the Jenkins instance starts up as global enironment
* ```aws_vpc_id```: Assigned when the Jenkins instance starts up as global environment variable
* ```aws_region```: Assigned when the Jenkins instance starts up as global environment variables
* ```packer_iam_groups```: Needed for ssh access when launching packer instances locally to sandbox
* ```packer_iam_groups```: Needed for ssh access when launching packer instances locally to sandbox
* ```packer_ssh_username```: Local environment variable as your aws username
* ```packer_ssh_agent_auth```: Use the ssh agent
* ```tag_user```: User running the packer command
* ```tag_build_url```: Jenkins default environment variable
* ```tag_build_tag```: Jenkins default environment variable

The ```builders``` section passes the options to build the instance for Packer:

```json
"builders": [
    {
      "type": "amazon-ebs",
      "region": "{{user `aws_region`}}",
      "subnet_id": "{{user `aws_subnet_id`}}",
      "vpc_id": "{{user `aws_vpc_id`}}",
      "source_ami_filter": {
        "filters": {
          "virtualization-type": "hvm",
          "name": "ubuntu-1804-base-*",
          "tag:Tests": "Passed"
        },
        "owners": [
          "370807233099",
          "419929493928"
        ],
        "most_recent": true
      },
      "instance_type": "t2.micro",
      "iam_instance_profile": "Packer",
      "run_tags": {
        "Name" : "packer-<component-name>",
        "auth-account-arn": "arn:aws:iam::638924580364:role/RoleCrossAccountSSH",
        "iam-groups": "{{user `packer_iam_groups`}}",
        "user": "{{user `tag_user`}}",
        "build-url": "{{user `tag_build_url`}}",
        "build-tag": "{{user `tag_build_tag`}}"
      },
    "tags": {
      "Name": "<component-name>",
      "build-url": "{{user `tag_build_url`}}",
      "build-tag": "{{user `tag_build_tag`}}"
    },
      "ssh_username": "{{user `packer_ssh_username`}}",
      "ssh_private_key_file": "{{user `packer_ssh_private_key_file`}}",
      "ssh_agent_auth": "{{user `packer_ssh_agent_auth`}}",
      "associate_public_ip_address": "true",
      "ami_name": "ubuntu-1804-<component-name>-{{timestamp}}"
    }
  ]
```

Packer builder options can be read on [the official documentation](https://www.packer.io/docs/builders/amazon-ebs.html). The important ones we use:
* ```source_ami_filter```: We're searching for the latest ```ubuntu-1804-base-*``` AMI owned by the sandbox or management accounts (they share succesfully built AMIs) and have a tag named ```Tests``` with value ```Passed```.
* ```run_tags```: The tags intended for the instance running Packer, important for SSH access and identifying who started it.
* ```tags```: Tags for the built AMI. Upon succesfull tests we add an additional tag of ```Tests:Passed``` through the pipeline job.

The ```provisioners``` block copies the ```files``` folder to remote ```/tmp``` folder and runs the custom script from the local ```scripts/``` folder.

```json
"provisioners": [
    {
      "type": "file",
      "source": "files",
      "destination": "/tmp"
    },
    {
      "type": "shell",
      "execute_command": "sudo -E bash '{{ .Path }}'",
      "scripts": [
        "scripts/init-1804-<component-name>.sh"
      ]
    }
  ]
```

### Test-kitchen template

The [test-kitchen](http://kitchen.ci/docs/getting-started) yaml template file passes options to build the instance for the tests and run them.

```yaml
---
driver:
  name: ec2
  subnet_id: <%= ENV['AWS_SUBNET_ID'] %>
  security_group_filter:
    tag: Name
    value: test-kitchen
```
* ```subnet_id```: Global environment variable defined by Jenkins on startup.
* ```security_group_filter```: Gets the SG tagged with the apropriate key and value.

We define how we connect to the created instance. Due to different environment variables from local and jenkins jobs, the connections will be different. Locally we will need to export ```TEST_KITCHEN_USER``` and ```TEST_KITCHEN_SSH_KEY```:

```yaml
transport:
  username: <%= ENV['TEST_KITCHEN_USER'] || 'test-kitchen' %>
  <% if ENV['TEST_KITCHEN_SSH_KEY'] %>
  ssh_key: <%= ENV['TEST_KITCHEN_SSH_KEY'] %>
  <% end %>
```

We are not using any provisioners. This is here just so test-kitchen doesn't install chef on the box.
```yaml
provisioner:
  name: shell
```

Various options can be found in the test-kitchen [documentation for ec2](https://github.com/test-kitchen/kitchen-ec2#configuration), important ones described bellow the sample code

```yaml
platforms:
  - name: ubuntu-18.04
    driver:
      region: <%= ENV['AWS_DEFAULT_REGION'] %>
      associate_public_ip: true
      instance_type: t2.medium
      image_id: <%= ENV['TEST_KITCHEN_AMI'] %>
      iam_profile_name: TestKitchen
      tags:
        Name: test-kitchen-<component>
        Env: <%= ENV['AWS_ENVIRONMENT'] %>
        iam-groups: <%= ENV['TEST_KITCHEN_IAM_GROUPS'] || 'webops_engineer' %>
        auth-account-arn: arn:aws:iam::638924580364:role/RoleCrossAccountSSH
        user: <%= ENV['USER'] %>
        <% if ENV['BUILD_URL'] %>
        build-url: <%= ENV['BUILD_URL'] %>
        build-tag: <%= ENV['BUILD_TAG'] %>
        <% end %>
```

* ```image_id```: it's passed automatically during the build jobs, when specified locally, please export ```TEST_KITCHEN_AMI```.
* ```tags```: tags for the created instance, needed to allow ssh and identify instance

Test suites live in the ```test/integration/cis/``` and ```test/integration/cis-dil-benchmark/``` folders:

```yaml
suites:
  - name: cis
    verifier:
      name: inspec
      attributes:
        cis_level: "1"
```

### env.sh

You will need to source the ```env.sh``` file to populate your environment with variables needed to run packer and teskitchen locally.

```bash
#!/usr/bin/env sh
export AWS_PROFILE=webops-sandbox
export AWS_DEFAULT_PROFILE=$AWS_PROFILE

unset AWS_ACCESS_KEY_ID
unset AWS_SECRET_ACCESS_KEY
unset AWS_SESSION_TOKEN
aws iam list-roles > /dev/null
export AWS_ACCESS_KEY_ID=`cat $HOME/.aws/cli/cache/*arn_aws_iam__370807233099_role-RoleSandboxAccess.json | jq -c '.Credentials.AccessKeyId' | tr -d '"' | tr -d ' '`
export AWS_SECRET_ACCESS_KEY=`cat $HOME/.aws/cli/cache/*arn_aws_iam__370807233099_role-RoleSandboxAccess.json | jq -c '.Credentials.SecretAccessKey' | tr -d '"' | tr -d ' '`
export AWS_SESSION_TOKEN=`cat $HOME/.aws/cli/cache/*arn_aws_iam__370807233099_role-RoleSandboxAccess.json | jq -c '.Credentials.SessionToken' | tr -d '"' | tr -d ' '`

export AWS_ENVIRONMENT=sandbox
export AWS_DEFAULT_REGION=eu-west-2
export AWS_VPC_ID=$(aws ec2 describe-vpcs --filters "Name=tag:Env,Values=${AWS_ENVIRONMENT}" --output text --query 'Vpcs[0].VpcId')
export AWS_SUBNET_ID=$(aws ec2 describe-subnets --filter "Name=vpc-id,Values=${AWS_VPC_ID},Name=tag:Name,Values=ci*" --output text --query 'Subnets[0].SubnetId')
```

### Jenkins vars file

Jenkins jobs use the ```jenkins-packervars.json``` file by default:

```json
{
  "packer_iam_groups": "ssh_only",
  "packer_ssh_username": "packer",
  "packer_ssh_private_key_file": "/var/lib/jenkins/.ssh/packer_id_rsa",
  "packer_ssh_agent_auth": "false"
}
```
