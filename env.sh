#!/usr/bin/env sh
export AWS_PROFILE=devops-sandbox
export AWS_DEFAULT_PROFILE=$AWS_PROFILE
export AWS_ENVIRONMENT_TAG=sandbox
export AWS_DEFAULT_REGION=eu-west-2

unset AWS_ACCESS_KEY_ID
unset AWS_SECRET_ACCESS_KEY
unset AWS_SESSION_TOKEN

aws iam list-roles > /dev/null

export AWS_ACCESS_KEY_ID
export AWS_SECRET_ACCESS_KEY
export AWS_SESSION_TOKEN

export AWS_VPC_ID
export AWS_SUBNET_ID
export AWS_PACKER_SUBNET

AWS_ACCESS_KEY_ID=$(cat "$HOME"/.aws/cli/cache/*.json | jq -c '.Credentials.AccessKeyId' | tr -d '"' | tr -d ' ')
AWS_SECRET_ACCESS_KEY=$(cat "$HOME"/.aws/cli/cache/*.json | jq -c '.Credentials.SecretAccessKey' | tr -d '"' | tr -d ' ')
AWS_SESSION_TOKEN=$(cat "$HOME"/.aws/cli/cache/*.json | jq -c '.Credentials.SessionToken' | tr -d '"' | tr -d ' ')

AWS_VPC_ID=$(aws ec2 describe-vpcs --filters "Name=tag:Env,Values=${AWS_ENVIRONMENT_TAG}" --output text --query 'Vpcs[0].VpcId')
AWS_SUBNET_ID=$(aws ec2 describe-subnets --filter "Name=vpc-id,Values=${AWS_VPC_ID}" "Name=tag:Name,Values=ci*" --output text --query 'Subnets[0].SubnetId')
AWS_PACKER_SUBNET=$AWS_SUBNET_ID