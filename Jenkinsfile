pipeline {
  agent {
    docker {
      image 'chef/chefdk'
      args '-u root -v /var/run/docker.sock:/var/run/docker.sock'
    }
  }
  stages {
    stage ('env update and info') {
      steps {
        sh '/opt/chefdk/bin/chef --version'
        sh '/opt/chefdk/bin/chef exec gem list'
        sh 'yum -y install git docker'
        sh 'service docker start'
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
        sh '/opt/chefdk/bin/chef exec kitchen create'
        sh 'sleep 10'
        sh '/opt/chefdk/bin/chef exec kitchen converge --log-level debug'
        sh '/opt/chefdk/bin/chef exec kitchen verify'
        sh '/opt/chefdk/bin/chef exec kitchen destroy'
      }
    }
  }
  post {
    always {
      sh '/opt/chefdk/bin/chef exec kitchen destroy'
    }
  }
}
