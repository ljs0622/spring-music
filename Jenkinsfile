pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                git 'https://github.com/ljs0622/spring-music.git'
                sh "./gradlew build"
            }
        }
        stage('Docker Build') {
            environment {
                WEB_IMAGE_NAME="${ACR_LOGINSERVER}/spring-music:kube${BUILD_NUMBER}"
                ACR_CREDS = credentials('acr-credentials')
            }
            steps {
                sh "docker build -t $WEB_IMAGE_NAME ."
                sh "docker login ${ACR_LOGINSERVER} -u ${ACR_CREDS_USR} -p ${ACR_CREDS_PSW}"
                sh "docker push ${WEB_IMAGE_NAME}"
            }
        }
        stage('Deploy') {
            steps {
                sh "az aks get-credentials --resource-group ResourceGroup-Test-LJS --name AKS-LJS-TEST"
                sh "kubectl get po -A"
            }
        }
    }
}


//az aks get-credentials --resource-group ResourceGroup-Test-LJS --name AKS-LJS-TEST
