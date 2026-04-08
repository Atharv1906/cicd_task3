pipeline {
    agent any

    tools {
        nodejs "Node 7.8.0"
    }

    environment {
        IMAGE_NAME = ""
        PORT = ""
    }

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Set Environment') {
            steps {
                script {
                    if (env.BRANCH_NAME == 'main') {
                        env.IMAGE_NAME = "nodemain:v1.0"
                        env.PORT = "3000"
                    } else {
                        env.IMAGE_NAME = "nodedev:v1.0"
                        env.PORT = "3001"
                    }
                }
            }
        }

        stage('Install Dependencies') {
            steps {
                sh 'npm install'
            }
        }

        stage('Build') {
            steps {
                sh 'npm run build || true'
            }
        }

        stage('Test') {
            steps {
                sh 'npm test || true'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t ${IMAGE_NAME} .'
            }
        }

        stage('Deploy') {
            steps {
                script {
                    sh """
                    docker stop app_${PORT} || true
                    docker rm app_${PORT} || true
                    docker run -d -p ${PORT}:3000 --name app_${PORT} ${IMAGE_NAME}
                    """
                }
            }
        }
    }
}
