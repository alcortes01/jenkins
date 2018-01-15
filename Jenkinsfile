pipeline {
  agent {
    docker {
      image 'centos7-systemd'
      args '-u root'
    }
  }
  environment {
    machine_port = '22'
    machine_user = 'root'
//    machine_password = ''
  }
//  parameters {
//    booleanParam(
//      defaultValue: true,
//      description: 'choose true or false to continue',
//      name: 'userFlag'
//    )
//  }
//  parameters {
//    string(
//      defaultValue: "TEST",
//      description: "What environment?",
//      name: 'userFlag'
//    )
//    choice(
//      choices: 'US-EAST-1\nUS-WEST-2',
//      description: 'What AWS region?',
//      name: 'region')
//  }
  stages {
    stage('Dependencies') {
      steps {
        sh 'curl https://omnitruck.chef.io/install.sh | bash -s -- -c current -P chefdk'
        sh 'eval chef shell-init bash'
        sh 'yum install -y openssh-server'
        sh 'ssh-keygen -A'
        sh 'ssh-keygen -t rsa -N "" -f /root/.ssh/id_rsa'
        sh 'cat /root/.ssh/id_rsa.pub > /root/.ssh/authorized_keys'
        sh '/usr/sbin/sshd &'
      }
    }
//    stage('Verify dependencies') {
//      steps {
//        sh 'chef verify'
//        sh 'KITCHEN_LOCAL_YAML=.kitchen.jenkins.yml kitchen list'
//      }
//    }
    stage('Run test-kitchen') {
//      when {
//        anyOf { branch 'master'; branch 'staging'; branch 'production' }
//      }
      steps {
        script {
          env.CONTINUE = input message: 'Continue?',
          ok: 'Continue!'
//          parameters: [choice(name: 'CONTINUE', choices: 'patch\nminor\nmajor', description: 'What is the release scope?')]
        }
        echo "flag: ${env.CONTINUE}"
        sh 'KITCHEN_LOCAL_YAML=.kitchen.jenkins.yml kitchen test centos-7'
      }
    }
//    stage('\u27A1 Upload to Chef Server') {
//      when {
//        branch 'production'
//      }
//      steps {
//        sh 'chef exec knife cookbook upload COOKBOOKNAME -o ../'
//      }
//    }
  }
  post {
    failure {
      sh 'kitchen diagnose --all'
    }
  }
}
