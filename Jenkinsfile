pipeline {
  agent any
  stages {
    stage('build jar') {
      steps {
        sh '''mvn clean package -U -DskipTests=true -Dmaven.javadoc.skip=true
cp target/app.jar src/main/docker/app.jar



'''
      }
    }

    stage('build images') {
      steps {
        sh 'docker build --pull -t gsp-sit/stg01-tky-ecr-gsp-admin-gsp-fr:sit ${1:-"src/main/docker"}'
      }
    }

    stage('push images') {
      steps {
        sh 'docker push gsp-sit/stg01-tky-ecr-gsp-admin-gsp-fr:sit'
      }
    }

    stage('deploy') {
      steps {
        sh 'pwd'
      }
    }

  }
}