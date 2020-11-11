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
            steps {
                sh "ls -al"
                sh "docker --version"
                sh "docker build -t spring-music ."
                sh "docker login acrtestljs.azurecr.io"
                sh "docker tag spring-music acrtestljs.azurecr.io/spring-music/springmusic:$BUILD_NUMBER"
                sh "docker login acrtestljs.azurecr.io"
                sh "docker push acrtestljs.azurecr.io/spring-music/springmusic:$BUILD_NUMBER"
            }
        }
    }
}