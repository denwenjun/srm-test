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
        sh 'docker build --pull -t 029937289256.dkr.ecr.ap-northeast-1.amazonaws.com/gsp-sit/stg01-tky-ecr-gsp-admin-gsp-fr:sit ${1:-"src/main/docker"}'
      }
    }

    stage('push images') {
      steps {
        sh '''aws ecr get-login-password --region ap-northeast-1 | docker login --username AWS --password-stdin 607422664064.dkr.ecr.ap-northeast-1.amazonaws.com
docker push 029937289256.dkr.ecr.ap-northeast-1.amazonaws.com/gsp-sit/stg01-tky-ecr-gsp-admin-gsp-fr:sit'''
      }
    }

    stage('deploy') {
      steps {
        sh 'kubectl get node'
      }
    }

  }
}