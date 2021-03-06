#!/usr/bin/env groovy
env.BUILD_TARGET = "target"
env.PACKER_LOG = 1
env.PACKER_LOG_PATH = "${env.BUILD_TARGET}/packer.log"
env.TEST_KITCHEN_IAM_GROUPS = 'ssh_only'
env.TEST_KITCHEN_SSH_KEY = '/var/jenkins_home/.ssh/test_kitchen_id_rsa'
env.BUCKET_NAME = "fbplatform-shared-management-hardening-output"

//node ('amislave') {
node ('master') {
  stage('Prepare') {
    step([$class: 'WsCleanup'])
    checkout(scm)
    sh('git submodule update --init --remote')
  }

  stage('Build') {
    ansiColor('xterm') {
      sh("rm -rf ${env.BUILD_TARGET}/ ; mkdir -p ${env.BUILD_TARGET}")
      sh(". ./env.sh && packer build -var-file=jenkins-packervars.json templates/ami-ubuntu-1804-base.json")
    }

    writeFile(file: "${env.BUILD_TARGET}/ami_id.txt",
              text: sh(script: "awk '/^${env.AWS_DEFAULT_REGION}: ami-.{8}/ { print \$2 }' ${env.PACKER_LOG_PATH}",
                       returnStdout: true))
    stash(includes: "${env.BUILD_TARGET}/ami_id.txt", name: 'ami_id')
    sh("cat ${env.BUILD_TARGET}/ami_id.txt")
    archiveArtifacts("${env.BUILD_TARGET}/*")
  }

  try {
    sh('nice -n 19 bundle install --deployment --path ${HOME}/.bundler_cache')
    parallel(
      inspec: { RunTest("inspec") },
      cis: { RunTest("cis") },
      lynis: { RunTest("lynis") },
    )
  } catch (e) {
    currentBuild.result = 'FAILURE'
    throw e
  } finally {
    PostTests()
  }
}

def RunTest(String TestType){
  stage(TestType) {
    ansiColor('xterm') {
      sh("mkdir -p ${env.BUILD_TARGET}/${TestType}")
      sh(". ./env.sh && JUNIT_XML=${env.BUILD_TARGET}/${TestType}/${TestType}_test_kitchen.xml TEST_KITCHEN_AMI=\$(cat ${env.BUILD_TARGET}/ami_id.txt) bundle exec kitchen verify ${TestType}")
      if (TestType == 'inspec') {
        archiveArtifacts("${env.BUILD_TARGET}/${TestType}/${TestType}_test_kitchen.xml")
      } else if (TestType == 'cis') {
        archiveArtifacts("${env.BUILD_TARGET}/${TestType}/${TestType}_test_kitchen.xml")
      } else if ( TestType == 'lynis' ){
        sh("bundle exec kitchen exec ${TestType} -c 'sudo cat /var/log/lynis.log' > .kitchen/logs/lynis.log")
        sh("bundle exec kitchen exec ${TestType} -c 'sudo cat /var/log/lynis-report.dat' > .kitchen/logs/lynis-report.dat")
      }
    }
  }
}

def PostTests(){
  stage('Upload test results to S3'){
    def tags = ""
    if (currentBuild.result == 'FAILURE') {
      tags = "\"TagSet=[{Key=status,Value=FAILURE},{Key=build_number,Value=\${BUILD_NUMBER}}]\""
    } else {
      tags = "\"TagSet=[{Key=status,Value=SUCCESS},{Key=build_number,Value=\${BUILD_NUMBER}},{Key=ami-id,Value=\$(cat ${env.BUILD_TARGET}/ami_id.txt)}]\""
    }

    ansiColor('xterm') {
      sh(". ./env.sh && bundle exec kitchen destroy all")
      sh("""#!/bin/bash
            set -euox

            job_date=\$(date \'+%Y-%m-%d_%H:%M\')
            base_directory=\"test_results\"
            ami_id=\$(cat ${env.BUILD_TARGET}/ami_id.txt)
            job_directory=\"${JOB_NAME}/base_\${ami_id}_\$job_date\"
            mkdir -p \$base_directory/\$job_directory
            cp .kitchen/logs/lynis* \$base_directory/\$job_directory
            cp ${env.BUILD_TARGET}/inspec/inspec_test_kitchen.xml \$base_directory/\$job_directory
            cp ${env.BUILD_TARGET}/cis/cis_test_kitchen.xml \$base_directory/\$job_directory
           
            # gain privs
            . ./env.sh

            aws s3 sync \$base_directory s3://${env.BUCKET_NAME}
            s3_objects=\$(aws s3 ls s3://${env.BUCKET_NAME}/\$job_directory/ | awk '{ print \$4 }')

            if [[ -n "\$s3_objects" ]]; then
              for obj in \$s3_objects; do
                aws s3api put-object-tagging --bucket ${env.BUCKET_NAME} --key \$job_directory/\$obj --tagging ${tags}
              done
            else
              echo "No objects were fetched from S3 - check the output files creation"
              exit 1
            fi
        """)
    }
  }

  if (currentBuild.result == 'FAILURE') {
    stage('Deregister AMI') {
      archiveArtifacts(".kitchen/logs/*")
      sh("""#!/bin/bash
            set -x
            ami_id=\$(cat ${env.BUILD_TARGET}/ami_id.txt)
            snapshot_id=\$(aws ec2 describe-images --image-ids \$ami_id --output text --query 'Images[*].BlockDeviceMappings[*].Ebs.SnapshotId')
            . ./env.sh
            aws ec2 deregister-image --image-id \$ami_id
            aws ec2 delete-snapshot --snapshot-id \$snapshot_id
         """)
    }
  } else {
    stage('Share AMI') {
      sh("""#!/bin/bash
            set -x
            ami_id=\$(cat ${env.BUILD_TARGET}/ami_id.txt)
            . ./env.sh aws ec2 create-tags --resource \$ami_id --tags Key=Tests,Value=Passed
         """)
      sh(". ./env.sh && aws ec2 modify-image-attribute --image-id \$(cat ${env.BUILD_TARGET}/ami_id.txt) --launch-permission '{\"Add\":[${generateLaunchPermissionArray()}]}'")
      archiveArtifacts("${env.BUILD_TARGET}/*")
    }
  }
}

def generateLaunchPermissionArray() {
  def user_ids = [
    '236048907885',
    '241579122070',
    '749772925301',
    '667236357946',
    '602766993137',
    '808981689443',
    '053115678442', 
    '687289330304'
  ]

  def list = ""
  for (u in user_ids) {
    list += "{\"UserId\":\"${u}\"},"
  }
  return list[0..-2] // delete trailing comma
}

