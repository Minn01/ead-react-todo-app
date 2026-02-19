pipeline {
    agent any

    stages {

        stage('Install Dependencies') {
            agent {
                docker {
                    image 'node:18-bullseye'
                    args '-u root'
                }
            }
            environment {
                PUPPETEER_SKIP_DOWNLOAD = 'true'
            }
            steps {
                sh '''
                apt-get update
                apt-get install -y python3 make g++ build-essential
                ln -sf /usr/bin/python3 /usr/bin/python
                npm install
                '''
            }
        }

        stage('Test') {
            agent {
                docker {
                    image 'node:18-bullseye'
                    args '-u root'
                }
            }
            steps {
                sh 'npm test'
            }
        }

        stage('Docker Build') {
            agent any
            steps {
                sh 'docker build -t minnthant/todo-app .'
            }
        }

        stage('Docker Push') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'docker-hub-credentials',
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
                )]) {
                    sh '''
                    echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
                    docker push minnthant/todo-app
                    '''
                }
            }
        }
    }
}