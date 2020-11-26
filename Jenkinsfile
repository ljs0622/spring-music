pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                // Get some code from a GitHub repository
                git 'https://github.com/ljs0622/spring-music.git'

                // Run Maven on a Unix agent.
                sh "pwd"
                sh "ls -al"
                sh "./gradlew build"
                // To run Maven on a Windows agent, use
                // bat "mvn -Dmaven.test.failure.ignore=true clean package"
            }
        }
        stage('Docker Build') {
            environment {
                WEB_IMAGE_NAME="${ACR_LOGINSERVER}/spring-music:kube${BUILD_NUMBER}"
            }
            steps {
                echo "${WEB_IMAGE_NAME}"
                sh "docker build -t $WEB_IMAGE_NAME ."
                sh "docker login ${ACR_LOGINSERVER} -u ${ACR_ID} -p ${ACR_PASSWORD}"
                sh "docker push ${WEB_IMAGE_NAME}"
            }
        }
    }
}