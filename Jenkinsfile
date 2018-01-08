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
    stage ('kitchen yaml file creation') {
      steps {
        sh 'cp .kitchen.dokken.yml .kitchen.local.yml'
      }
    }
    stage ('kitchen create') {
      steps {
        sh '/opt/chefdk/bin/chef exec kitchen create'
      }
    }
    stage ('kitchen converge') {
      steps {
        sh '/opt/chefdk/bin/chef exec kitchen converge'
      }
    }
    stage ('kitchen verify') {
      steps {
        sh '/opt/chefdk/bin/chef exec kitchen verify'
      }
    }
  }
}
