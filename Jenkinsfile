pipeline {
  agent {
    docker {
      image 'open-registry.going-link.com/zhenyun/cibase:0.7.0'
    }

  }
  stages {
    stage('checkout') {
      steps {
        sh 'mvn clean package -U -DskipTests=true -Dmaven.javadoc.skip=true'
      }
    }

    stage('build') {
      steps {
        sh 'ls'
      }
    }

    stage('docker build ') {
      steps {
        sh 'ls'
      }
    }

    stage('docker push') {
      steps {
        sh 'ls'
      }
    }

    stage('k8s deploy') {
      steps {
        sh 'ls'
      }
    }

  }
}