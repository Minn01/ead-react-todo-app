pipeline {
    agent {
        docker {
            image 'node:18-bullseye'
            args '-u root'
        }
    }

    environment {
        CI = 'true'
    }

    stages {

        stage('Install Dependencies') {
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
            steps {
                sh 'npm test'
            }
        }

        stage('Docker Build') {
            steps {
                sh 'docker build -t minnthant/todo-app .'
            }
        }

        stage('Docker Push') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'docker-hub-credentials',
                    usernameVariable: 'DOCKER_USERNAME',
                    passwordVariable: 'DOCKER_PASSWORD'
                )]) {
                    sh '''
                    echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin
                    docker push minnthant/todo-app
                    '''
                }
            }
        }

    }
}