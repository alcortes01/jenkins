pipeline {
  agent { docker 'chef/chefdk' }
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
