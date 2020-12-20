pipeline {
  agent any
  stages {
    stage('build jar') {
      parallel {
        stage('build jar') {
          steps {
            sh '''mvn clean package -U -DskipTests=true -Dmaven.javadoc.skip=true
cp target/app.jar src/main/docker/app.jar



'''
          }
        }

        stage('k8s') {
          steps {
            podTemplate(label: 'aws', serviceAccount: 'jenkins') {
              sh '''kubectl get node'''
            }

          }
        }

      }
    }

    stage('build images') {
      steps {
        sh '''current=`date "+%Y%m%d%H%M%S"`
cat >> ./version <<EOF
sit-$current
EOF
version=sit-$current
docker build --pull -t ${DOCKER_IMAGE}:$version ${1:-"src/main/docker"}'''
      }
    }

    stage('push images') {
      parallel {
        stage('push images') {
          steps {
            sh '''docker login --username AWS --password ${ECR_PASSWORD} ${ECR_REGISTORY}
version=`tail -n 1 version`
docker push ${DOCKER_IMAGE}:$version'''
          }
        }

        stage('clean jar') {
          steps {
            sh 'rm -rf src/main/docker/app.jar'
          }
        }

      }
    }

    stage('clean images') {
      steps {
        sh '''version=`tail -n 1 version`
docker rmi ${DOCKER_IMAGE}:$version'''
      }
    }

  }
  environment {
    ECR_PASSWORD = 'eyJwYXlsb2FkIjoia1prY1lmZ2xiaWlza2tMR2J0S2ExbmZCU0VINGFjeExPMVEvVStMVlNNNUd0bEFhMk5NdjJkMWhRVHBEajVQM3BiUHRyKzlIMkRJUjU3eWpORWUvNThNamp0aFoyR1ZhTG10U1c5alg4R01FRm9nZE91OEtMS21VRzRTRmdkMERiL1JwdGhMYlZsa3Y3dm5IRllOMENFNWNKZnBjMHBseUs3b2d6S0ZNMWd1K2VYNTB1YWs1eUhpc1d3bkh3anhvYlVQZVhleWRHK0JycHh3Q1d0L0xTSDZ5d01tK0JJUFg3cjZlMjI0SmllZS9sb25zbktqVFcrRkxYVVFrOE5QeE1QcmhzZys4QVBIS2V5WkloSXRNbXUvOENiNVFvMUNsTGtGYlRtbTk1SVVGdmU0K05GNWUxVTlNcG9RSGsrOWl4ZmRPdlJnMDFrMzhRNUlKOHpwMWJhY3dHTU04WmNhYmIzc2FCL0FiZHR5RzUwYTliVEZWV3Mrak9TYkV6dFUzSDdSN1cwc2c1RjFBcjRtMVIwbE9uS1Q5cXd0OGtqcTdMUWwxVlFMSHEvRjNzQS9vUGxSZzFpbmRlTFJkZG9mTld0QXJrN0RLRWtJKzFYVmZzeHhGcWJFRGpBdWpTOUdmRUVvRFJaM01BRVBvcW04ZnNxZzZtQXR4cVlMR2FLdlpESEY2SDRYRFFMaVhESHgrWFRnNUNmM1F5cVpBSSswbHVxT2trQWVXMXltQVZPMWxVRHdyMHluemk4djQ4eW1SZ1RQQnM5SFFXbk9sQTdzNHF4SDBEbzdVNHRRQ2hqemJKK2w3QVYvTk5xQVNhNnEyNnRaSGE1cng0Zkw3UEJkckV1M0t2dC9UNzVEbVgwdDJZL05EZnltMEdzZXZuOWZtdEx2MUVTcE51eW1XeDlvei9LQlk0UXV4TkhnMVdZalhwb2gycUgweXFiTFI1RWhLN2RWL3ZxQS9aOGZlTXdZRWkvZVU5eWFOOCtUdlQrdXJsQ1o4cDR4MlhqMjQxRnJNNXZGMUNLVUNWdkUzb3dhUWRTQXJySHNOaUVvRGwzdWdJTWpNWStWUi9mU0pMTDBKTEtIRkdBVmlGYnA4TGhUT2dtd2JDdHFmd3RjU1dsOVZmNWQ0MDQ2Y2ROY3J6emdDMW9UL0dQS1dtMnZRZlR2eHN4QXVJUWprUWNlU1BsMnZsTFlRNlZCVmN3Q2lKNnIyd0ZaeWs2aG5hU0VpZjZKZkc3bmN0UDRrWVpudnV3MkhVR1pWcXFsYlRUWDRlcnNzTWxicEd2QlZMQ2ZjeDA1a2p5cFBlSldmc2EwV0g0YUdOdHdqQ0RoYWZWcXl5M1MyaTFYL1FBanR5NWdaQnZabzJXY2lLcFVDdmtRMHVNZ2hUNnkvRXh0L3didEtMRjd4QnFxeDlqZ3pCaUgwbmFyUkpnWllwSHlXaHRyUUgyOS83dE5OcmRoNVFkU3ZINS92YlZDZlJMOUtuR01nUzFKN2kzMmRoNFZEVVJKeVBFd2JVOG9meTJNLzNLTjlxZ0tQRnFkdjVKQm9lY0pDM1BzNGxhd1VqQjZQa3puMndoNnk1clR6QTVla1VJcnNtNXF5aThsYU0zMzRVSHBNZUJOWVR0L2Fha0ZXc2lqbU85Q2p6LzFhb2doRFBhcnUrd2ZKdHlnbnZKd0M4NC8yU0htTGxOa2tvK3NyWG5XVWNOVzVyZGZBVzJZTTBsS3Y5WXp0WGhkamVQb2lacjVabjJqSXhnZWQyOWVSZFg5RmlFQ0pXMzhDSGNSQnFHK29RQTlqdEZ5eDVBa0kyOTBaVlZBY2ZJN2JpTlZpcG5BQlEzNk0ycUhGdjNnUVNETVJrZGh1aEdEM2c3OEVpUEpYeURIYmFUTVBBU21CMFZtM3VZZHFhR1VEaDA0VjhsK0RnWlp2UXRURHgzTXdQT2VJbnRLOXVKcmFhSTFWSTZJc3Z0c1QxbTgvZTRhcXZxSVpnL1dqcXRLMVRoTzgwL09uVlJSUVdoWjh4SVgyMU5IQUJsK241Nk5YTnNaczJHV0hzTmhsMk95Y01JNjNKZUJxQkRjOUhDZzZsaVdBMTM3bzBRdm5SKzVLQUUvRWEva0hId1Z6VmxPYTI3WHpGVnNuZVovdlRVbWJnbTM3MmkwdnJxTDhJVEVTVXlzNEsxd2JEckNTU2tJVFpaUFd6cnR6SmZsVFNvRytzQURnWnZUY1NoNng5TVlIZXpvVHVSeE5vM1FzUXozUkJsSnZUWDRJeEpqbnU2Y2pnMENCQXhlakxBVTk4VTRaU0phaWtoYzlmN0xOU3ZFN2lLbkFpT2lQZVV1WHVwUWhlOVRrS3RFWm1wNE9rOW01SktWeHpYNE85L2FPRHFjPSIsImRhdGFrZXkiOiJBUUVCQUhnQU1mS0RsSW9wQzZ6czBiTWRScllTSGEvQzM5a0NyY1A4a1ZwckU5ZitrUUFBQUg0d2ZBWUpLb1pJaHZjTkFRY0dvRzh3YlFJQkFEQm9CZ2txaGtpRzl3MEJCd0V3SGdZSllJWklBV1VEQkFFdU1CRUVETllaWUl4WFFobXNSS3dCQ3dJQkVJQTdzbjBzcGw4UWlIVmlpODdQVWhwTmFFMUFyVDBQMVZmU1hNSFVHM3pNMlY3VlBIWHFLWFFWVXZjc3ZvVVV5ZmlBYUZIU01VOWpHL0VidVJVPSIsInZlcnNpb24iOiIyIiwidHlwZSI6IkRBVEFfS0VZIiwiZXhwaXJhdGlvbiI6MTYwODUwMDI2NX0='
    DOCKER_IMAGE = '607422664064.dkr.ecr.ap-northeast-1.amazonaws.com/gsp-sit/stg01-tky-ecr-gsp-register-gsp-fr'
    ECR_REGISTORY = '607422664064.dkr.ecr.ap-northeast-1.amazonaws.com'
    KUBE_CONFIG = 'apiVersion: v1 clusters: - cluster:     certificate-authority-data: LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSUN5RENDQWJDZ0F3SUJBZ0lCQURBTkJna3Foa2lHOXcwQkFRc0ZBREFWTVJNd0VRWURWUVFERXdwcmRXSmwKY201bGRHVnpNQjRYRFRJd01URXlOakF6TlRVek9Wb1hEVE13TVRFeU5EQXpOVFV6T1Zvd0ZURVRNQkVHQTFVRQpBeE1LYTNWaVpYSnVaWFJsY3pDQ0FTSXdEUVlKS29aSWh2Y05BUUVCQlFBRGdnRVBBRENDQVFvQ2dnRUJBS0x0ClFoNWlpMDk0dStMa0xzVFV5VG1ZMDBXMkJJRHdmaHNPV0NjUXEybk5wVkdSeXpLYjRJVkRHNmZwSXl4OEJaVlcKQlg1MGx3OTBSbGw0MFhWVHZ1NjJlc083WGZ4T1B5WnlxbjYxUTIzRlF5MVE0eEorcXlMK3hLZkZSbEI4RFRSaQpncHAvVXRLN0ROMlcwL09OLzV0ODdpMFFPWktTUFdPRW92QnpxbWJPTE8xdGh0a1lKOVpvd0lBRjZ2Q1ExNVJ2CjQ2enh6Y09oM2g4cmk3RzNUUEJsSXZTK3NFOElTbEhyN0NsSWdlUERSQ3dIYWJCNW9GQ0pQR3FVTEFJbmxrV2MKNFU5NHpWMk1FM1Byc1pCdDNnT0R2Z1VhZ3hhdlI2c1NGa2xTLytaa2Z4RWdSM1kxeU45SGxqNFhocHpVTFRScApsTEZvN0JqdGkyaCt5TkNQMkcwQ0F3RUFBYU1qTUNFd0RnWURWUjBQQVFIL0JBUURBZ0trTUE4R0ExVWRFd0VCCi93UUZNQU1CQWY4d0RRWUpLb1pJaHZjTkFRRUxCUUFEZ2dFQkFBMDNKY3FWdW5oZmcxdE51Rk13K3Z3ak5QMXAKbkpqWjVldGMzRlVtT3RocC9HamRnYU5jVU90M3NndHdmeCtUYmM5MkcwZFI1MmVZYUY1SlVtNGZDTmU5NU1QLwpXWkhHQkZiTVlSenlHWVFZT3pXMXBzTWFFY09kU2tGOVp3QWRzVndlUVhBWWFYVy9Cd01SV01od0RZOVZ3eFRmCkRxZ25oOGlCTFFQM2FrLzVIK0RUUDJMY3lWQjVJYk4zU0ZKOFZtQzMzblFqeWRhV1JSdWxBeGJPaXlWNDUvWkYKTTgxUENhRzZ5UXBmcVdqbWdLeTR1UDRhajNwdGVqWXdLM1dRMEpvMWx1bllLK1h3OHJqQkRvNE5xVm0ySlQ3egpVazRrZnhic0dNSHFyekl5MGp4QkkzZ0RqampoSjA5aDVSc0FvaklYd2t3WHRHTnpVUnR4enVmSjVKWT0KLS0tLS1FTkQgQ0VSVElGSUNBVEUtLS0tLQo=     server: https://3C56FF73F2CEFDDC1E5751C9CFE00610.gr7.ap-northeast-1.eks.amazonaws.com   name: stg01-tky-eks-gsp-fr.ap-northeast-1.eksctl.io contexts: - context:     cluster: stg01-tky-eks-gsp-fr.ap-northeast-1.eksctl.io     user: i-07362b90868d169a5@stg01-tky-eks-gsp-fr.ap-northeast-1.eksctl.io   name: i-07362b90868d169a5@stg01-tky-eks-gsp-fr.ap-northeast-1.eksctl.io current-context: i-07362b90868d169a5@stg01-tky-eks-gsp-fr.ap-northeast-1.eksctl.io kind: Config preferences: {} users: - name: i-07362b90868d169a5@stg01-tky-eks-gsp-fr.ap-northeast-1.eksctl.io   user:     exec:       apiVersion: client.authentication.k8s.io/v1alpha1       args:       - eks       - get-token       - --cluster-name       - stg01-tky-eks-gsp-fr       - --region       - ap-northeast-1       command: aws       env:       - name: AWS_STS_REGIONAL_ENDPOINTS         value: regional'
  }
}
