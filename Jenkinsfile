pipeline {
  agent {
    docker {
      image 'rhel7-init'
//      image 'dokken/centos-7'
      args '-u root'
    }
  }
  stages {
    stage('Install Dependencies') {
      steps {
        sh 'yum install -y initscripts'
        sh 'curl https://omnitruck.chef.io/install.sh | bash -s -- -c current -P chefdk'
        sh 'eval chef shell-init bash'
        sh 'yum install -y openssh-server openssh-clients'
        sh 'ssh-keygen -A'
        sh 'ssh-keygen -t rsa -N "" -f /root/.ssh/id_rsa'
        sh 'cat /root/.ssh/id_rsa.pub > /root/.ssh/authorized_keys'
        sh '/usr/sbin/sshd &'
        sh 'yum install -y sudo'
      }
    }
    stage('Run Linting tests') {
      parallel {
        stage('Foodcritic') {
          steps {
            sh '/opt/chefdk/bin/chef exec foodcritic -C -t correctness .'
          }
        }
        stage('Cookstyle') {
          steps {
            sh '/opt/chefdk/bin/chef exec cookstyle'
          }
        }
      }
    }
    stage('Integration Test: Kitchen Create') {
      steps {
        sh 'KITCHEN_LOCAL_YAML=.kitchen.jenkins.yml kitchen create rhel-7'
      }
    }
    stage('Integration Test: Kitchen Converge') {
      steps {
        sh 'KITCHEN_LOCAL_YAML=.kitchen.jenkins.yml kitchen converge rhel-7'
      }
    }
    stage('Integration Test: Kitchen Verify') {
      steps {
        sh 'KITCHEN_LOCAL_YAML=.kitchen.jenkins.yml kitchen verify rhel-7'
      }
    }
    stage('Integration Test: Kitchen Destroy') {
      steps {
        script {
          env.CONTINUE = input message: 'Next stage will cleanup environment',
          ok: 'Continue!'
        }
        echo "flag: ${env.CONTINUE}"
        sh 'KITCHEN_LOCAL_YAML=.kitchen.jenkins.yml kitchen destroy rhel-7'
      }
    }
  }
  post {
    failure {
      sh 'kitchen diagnose --all'
    }
  }
}
