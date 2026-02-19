pipeline {
    agent {
        docker {
            image 'ghcr.io/puppeteer/puppeteer:latest'
            args '-u root'
        }
    }

    environment {
        CI = 'true'
        PUPPETEER_SKIP_CHROMIUM_DOWNLOAD = 'true'
    }

    stages {

        stage('Install') {
            steps {
                sh 'npm install'
            }
        }

        stage('Test') {
            steps {
                sh 'npm test -- --watchAll=false'
            }
        }

        stage('Docker Build') {
            steps {
                sh 'docker build -t minn01/todo-app:latest .'
            }
        }

        stage('Docker Push') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'docker-hub-credentials',
                    usernameVariable: 'DOCKER_USERNAME',
                    passwordVariable: 'DOCKER_PASSWORD'
                )]) {

                    sh 'echo $DOCKER_PASSWORD | docker login -u $DOCKER_USERNAME --password-stdin'
                    sh 'docker push minn01/todo-app:latest'
                }
            }
        }
    }
}