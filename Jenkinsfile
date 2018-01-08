pipeline {
  agent {
    docker {
      image 'chef/chefdk'
    }
  }
  stages {
    stage ('foodcritic') {
      steps {
        sh 'sudo /opt/chefdk/bin/chef exec foodcritic -C -t correctness .'
      }
    }
    stage ('cookstyle') {
      steps {
        sh 'sudo /opt/chefdk/bin/chef exec cookstyle'
      }
    }
    stage ('kitchen create') {
      steps {
        sh 'sudo /opt/chefdk/bin/chef exec kitchen create'
      }
    }
    stage ('kitchen converge') {
      steps {
        sh 'sudo /opt/chefdk/bin/chef exec kitchen converge'
      }
    }
    stage ('kitchen verify') {
      steps {
        sh 'sudo /opt/chefdk/bin/chef exec kitchen verify'
      }
    }
  }
}
