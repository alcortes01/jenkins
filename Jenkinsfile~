pipeline {
  agent {
    docker {
      reuseNode false
      image 'chef/chefdk'
      args '-u root -v /var/run/docker.sock:/var/run/docker.sock'
    }
  }
  stages {
    stage ('env update and info') {
      steps {
        sh 'apt-get update'
        sh 'apt-get install -y sudo git build-essential apt-transport-https ca-certificates curl software-properties-common'
//        sh 'apt-get install -y docker'
//        sh 'service docker start'
//        sh 'docker run --rm hello-world'
      }
    }
    stage('\u27A1 Install Docker-CE') {
      steps {
        sh 'curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -'
        sh 'apt-key fingerprint 0EBFCD88'
        sh 'add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"'
        sh 'apt-get update'
        sh 'apt-get install -y docker-ce'
      }
    }
    stage('\u27A1 Start Docker') {
      steps {
        sh 'service docker start'
      }
    }
    stage('\u27A1 Verify Docker') {
      steps {
        sh 'docker run --rm hello-world'
      }
    }
    stage ('foodcritic') {
      steps {
        sh '/opt/chefdk/bin/chef exec foodcritic -C -t correctness .'
      }
    }
    stage ('cookstyle') {
      steps {
        sh '/opt/chefdk/bin/chef exec cookstyle'
      }
    }
    stage ('kitchen test') {
      steps {
        sh 'cp .kitchen.dokken.yml .kitchen.local.yml'
        sh '/opt/chefdk/bin/chef gem update kitchen-dokken'
        sh '/opt/chefdk/bin/chef exec kitchen test'
//        sh '/opt/chefdk/bin/chef exec kitchen create'
//        sh '/opt/chefdk/bin/chef exec kitchen converge --log-level debug'
//        sh '/opt/chefdk/bin/chef exec kitchen verify'
//        sh '/opt/chefdk/bin/chef exec kitchen destroy'
      }
    }
  }
  post {
    always {
      sh '/opt/chefdk/bin/chef exec kitchen destroy'
    }
  }
}
