pipeline {
  def Namespace = "default"
  def ImageName = "srm-test"
  def ECRLink = "https://029937289256.dkr.ecr.ap-northeast-1.amazonaws.com"
  def UserName = ""
  def Password = ""
  def K8sConfig = ""
  def ImageTag = "latest"
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


    stage('k8s deploy') {
          agent {
              docker {
                  image 'lwolf/helm-kubectl-docker'
              }
          }
          steps {
              sh "mkdir -p ~/.kube"
              sh "echo ${K8sConfig} | base64 -d > ~/.kube/config"
              sh "sed -i 's/<APP_NAME>/${ImageName}/' deployment.yaml"
              sh "Image = ${ECRLink}/${ImageName}
                  sed -i 's/<IMAGE_NAME>/${Image}/' deployment.yaml"
              sh "sed -i 's/<IMAGE_TAG>/${ImageTag}/' deployment.yaml"
              sh "kubectl apply -f ./k8s/deployment.yml --record"
          }
    }

  }
}