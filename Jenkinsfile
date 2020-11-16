pipeline {
  agent {
    node {
      label 'dockerserver'
    }

  }
  stages {
    stage('build') {
      steps {
        sh 'docker info'
      }
    }

  }
}