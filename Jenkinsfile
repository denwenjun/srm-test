pipeline {
  agent { label 'dockerserver' }
  stages {
    stage('build') {
      agent {
        docker {
          label 'dockerserver'
          image 'maven:3-jdk-8-alpine'
          args '-v /root/.m2:/root/.m2'
        }
      }
      steps {
        sh 'mvn clean package -U -DskipTests=true -Dmaven.javadoc.skip=true'
      }
    }

  }
}