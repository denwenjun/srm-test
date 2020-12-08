pipeline {
  agent any
  stages {
    stage('build jar') {
      steps {
        sh 'java -version'
      }
    }

    stage('build images') {
      steps {
        sh 'mvn -v'
      }
    }

    stage('push images') {
      steps {
        sh 'docker info'
      }
    }

    stage('deploy') {
      steps {
        sh 'pwd'
      }
    }

  }
}