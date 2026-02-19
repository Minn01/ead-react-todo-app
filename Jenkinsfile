pipeline {
    agent {
        docker {
            image 'node:18-bullseye'
            args '-u root'
        }
    }

    environment {
        CI = 'true'
        PUPPETEER_SKIP_CHROMIUM_DOWNLOAD = 'true'
        PUPPETEER_EXECUTABLE_PATH = '/usr/bin/chromium'
    }

    stages {

        stage('Install Chromium') {
            steps {
                sh '''
                    apt-get update
                    apt-get install -y chromium
                '''
            }
        }

        stage('Install Dependencies') {
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