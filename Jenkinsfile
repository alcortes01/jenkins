pipeline {
  agent {
    docker {
      image 'chef/chefdk'
      args '-u root -v /var/run/docker.sock:/var/run/docker.sock'
    }
  }
  stages {
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
        sh '/opt/chefdk/bin/chef exec kitchen converge'
        sh '/opt/chefdk/bin/chef exec kitchen verify'
        sh '/opt/chefdk/bin/chef exec kitchen destroy'
      }
    }
  }
}
