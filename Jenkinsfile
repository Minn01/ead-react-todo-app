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
            agent any
            steps {
                sh '''
                docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD
                docker push minnthant/todo-app
                '''
            }
        }
    }
}