pipeline {
  agent {
    docker {
      image 'centos:7'
    }
  }
//  environment {
//    use_port = '22'
//    use_user = ''
//    use_password = ''
//  }
  stages {
    stage('Dependencies') {
      steps {
        sh 'curl https://omnitruck.chef.io/install.sh | sudo bash -s -- -c current -P chefdk'
        sh 'eval \$(chef shell-init bash) >> ~/.bash_profile'
        sh 'chef verify'
      }
    }
    stage('Verify dependencies') {
      steps {
        sh 'chef verify'
        sh 'KITCHEN_LOCAL_YAML=.kitchen.jenkins.yml kitchen list'
      }
    }
    stage('Run test-kitchen') {
//      when {
//        anyOf { branch 'master'; branch 'staging'; branch 'production' }
//      }
      steps {
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
}
