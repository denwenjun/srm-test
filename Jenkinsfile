node {
    def Namespace = "default"
    def ImageName = "stg01-a-tky-ecr-gsp-fr-register"
    def ECRLink = "https://575516539389.dkr.ecr.ap-southeast-2.amazonaws.com"

    stage ('Checkout'){
        final scmVars = checkout(scm)
        ImageTag = "${checkout(scm).GIT_COMMIT}"
    }

//     stage('Docker Build and Push'){
//         dir("${env.WORKSPACE}"){
//             docker.build("${ImageName}:latest")
//         }
//
//         docker.withRegistry("${ECRLink}", 'ecr:ap-southeast-2:helloworld-ecr'){
//             docker.image("${ImageName}").push("${ImageTag}")
//         }
//      }
//
//     stage('Deploy helloworld on K8s'){
//         dir("${env.WORKSPACE}"){
//             sh "kubectl ./CI-CD/deploy/Jenkins_deploy_playbook.yml  --extra-vars ECRLink=${ECRLink}  --extra-vars ImageName=${ImageName} --extra-vars imageTag=${ImageTag} --extra-vars Namespace=${Namespace}"
//         }
//     }
    stage ('Build'){
        steps {
            sh '''mvn clean package'''
        }
    }
    stage ('Docker Build and Push'){
//           steps {
//             sh '''cp Dockerfile ${HYBRIS_TEMP_DIR}/hybrisServer/
//             cd ${HYBRIS_TEMP_DIR}/hybrisServer/
//             sudo docker build -t docker-registry.moco.com/dev/epo_oms_hybris6700 .
//             sudo docker login docker-registry.moco.com -u ${ACCESS} -p ${PASSWORD}
//             sudo docker push docker-registry.moco.com/dev/epo_oms_hybris6700'''
//             }
    }
}