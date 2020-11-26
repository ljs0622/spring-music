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
            withCredentials([azureServicePrincipal(credentialsId: 'credentials_id',
                                                subscriptionIdVariable: 'SUBS_ID',
                                                clientIdVariable: 'CLIENT_ID',
                                                clientSecretVariable: 'CLIENT_SECRET',
                                                tenantIdVariable: 'TENANT_ID')]) {
                sh 'az login --service-principal -u $CLIENT_ID -p $CLIENT_SECRET -t $TENANT_ID'
            }
            steps {
                sh "az aks get-credentials --resource-group ResourceGroup-Test-LJS --name AKS-LJS-TEST"
                sh "kubectl get po -A"
            }
        }
    }
}


//az aks get-credentials --resource-group ResourceGroup-Test-LJS --name AKS-LJS-TEST
