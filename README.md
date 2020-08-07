# futureborders-aws-ubuntu-base-1804
# Ubuntu Base AMI

This repo contains the packer and test-kitchen config necessary to build and
test the Ubuntu Base AMI which all other AMIs are built from. This process
should be driven by Jenkins.

## Running locally

### Prepare the environment

You'll need an AWS profile called `devops-sandbox` configured on your machine. 

Your aws config should look this this:

    ...

    [sandbox]
    region = eu-west-2
    output = json

    [profile devops-sandbox]
    role_arn = arn:aws:iam::667236357946:role/PackerProvisioner
    mfa_serial = arn:aws:iam::667236357946:mfa/devops
    source_profile = sandbox

Whilst your credentials file like this:

    ...

    [sandbox]
    aws_access_key_id = access-key-id
    aws_secret_access_key = secret-access-key

Next step is to get the temporary tokens by sourcing `env.sh` and entering the MFA when asked:

```shell
$ . env.sh
Enter MFA code:
```

The token expires in a few minutes. When it does, any commands against the AWS API will start failing with expiry messages. When that happens, re-source the script to get the new tokens.

### Building the AMI

```shell
packer build templates/ami-ubuntu-1804-base.json
```

This will output the AMI ID that you will need to pass to `test-kitchen`.

### Running tests

The tests are wrapped by test kitchen. In CI, this will follow the process:
Start AMI
SSH in and run tests
Destroy instance

If you are developing tests locally, you can split up these steps to make life easier/quicker:

```shell
export TEST_KITCHEN_USER=<AWS username> # Used to SSH into the test instance -- perhaps use direnv to set it automatically?
export TEST_KITCHEN_SSH_KEY=</path/to/ssh/key>
export TEST_KITCHEN_AMI=<ami-id> # The AMI we wish to test, ideally the one created with packer previously
bundle install # Ensure gems are installed
bundle exec kitchen verify # run tests (can be repeated, and will run against the same instance)
bundle exec kitchen login # SSH to instance
bundle exec kitchen destroy # terminate the instance
```

## Hardening tests on new AMI

We use [lynis](https://cisofy.com/lynis/) to check our OS config meets
the relevant CIS Benchmark. The tests are run via Test Kitchen, and
the outputs of these tests are stored in Management S3 inside
`fbplatform-shared-management-hardening-output` and
are tagged accordingly to the job run results.