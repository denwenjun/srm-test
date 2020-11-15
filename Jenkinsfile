pipeline {
  agent {
    docker {
      image 'open-registry.going-link.com/zhenyun/cibase:0.7.0'
    }

  }
  stages {
    stage ('checkout'){
        final scmVars = checkout(scm)
        ImageTag = "${checkout(scm).GIT_COMMIT}"
    }

    stage('build') {
      steps {
        sh 'mvn clean package -U -DskipTests=true -Dmaven.javadoc.skip=true'
      }
    }
  }
}