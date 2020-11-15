env.IMAGE_NAME = 'srm-test'
env.IMAGE_TAG = '0.0.1'
env.REPOSITORIES_ADDRESS = 'https://029937289256.dkr.ecr.ap-northeast-1.amazonaws.com/'
env.REGISTER_ACCOUNT = "srm-aws-account"
pipeline {
  agent {
    docker {
      image 'open-registry.going-link.com/zhenyun/cibase:0.7.0'
    }
  }

  stages {

    stage('build') {
      steps {
        sh 'mvn clean package -U -DskipTests=true -Dmaven.javadoc.skip=true'
      }
    }

    stage('docker build') {
      docker.withRegistry('https://029937289256.dkr.ecr.ap-northeast-1.amazonaws.com/', 'ecr:ap-northeast-1:${env.REGISTER_ACCOUNT}') {

          def customImage = docker.build("${env.IMAGE_NAME}:${env.IMAGE_TAG}")

          customImage.push()
      }
    }

    stage("Deploy in AWS"){
      agent {
          docker {
              image 'lwolf/helm-kubectl-docker'
          }
      }
      steps{
        withCredentials([
            file(credentialsId: 'sit_kubeconfig', variable: 'KUBECONFIG')
         ]){sh """
                kubectl -n stg-srm delete -f ./deploy --ignore-not-found=true
                kubectl -n stg-srm apply -f ./deploy
                kubectl -n stg-srm get pod -o wide
                """
           }
      }
    }
  }
}