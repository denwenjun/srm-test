pipeline {
  agent any
  stages {
    stage('build jar') {
      steps {
        sh 'echo $PATH'
      }
    }

    stage('build images') {
      steps {
        sh 'docker info'
      }
    }

    stage('push images') {
      steps {
        sh 'ls'
      }
    }

    stage('deploy') {
      steps {
        sh 'pwd'
      }
    }

  }
}