pipeline {
  agent any
  stages {
    stage('build') {
      agent {
        docker {
          image 'maven:3-jdk-8-alpine'
        }

      }
      steps {
        sh 'mvn clean package -U -DskipTests=true -Dmaven.javadoc.skip=true'
      }
    }

  }
}