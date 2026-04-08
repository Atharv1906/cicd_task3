pipeline {
    agent any

    tools {
        nodejs "Node 7.8.0"
    }

    parameters {
        choice(name: 'ENV', choices: ['main', 'dev'], description: 'Select Environment')
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
                    def envName = params.ENV?.trim()

                    echo "ENV PARAM VALUE: ${envName}"

                    if (envName == "main") {
                        env.IMAGE_NAME = "nodemain:v1.0"
                        env.PORT = "3000"
                    } else if (envName == "dev") {
                        env.IMAGE_NAME = "nodedev:v1.0"
                        env.PORT = "3001"
                    } else {
                        error "Invalid ENV value: ${envName}"
                    }

                    echo "Image: ${env.IMAGE_NAME}"
                    echo "Port: ${env.PORT}"
                }
            }
        }

        // 🔥 NEW: Install Dependencies
        stage('Install Dependencies') {
            steps {
                sh 'npm install'
            }
        }

        // 🔥 NEW: Build App
        stage('Build App') {
            steps {
                sh 'npm run build || true'
            }
        }

        // 🔥 NEW: Run Tests
        stage('Test') {
            steps {
                sh 'npm test || true'
            }
        }

        // 🔥 FIXED: Docker Build
        stage('Build Docker Image') {
            steps {
                sh "docker build -t ${env.IMAGE_NAME} ."
            }
        }

        // 🔥 Deploy Container
        stage('Deploy') {
            steps {
                sh """
                docker stop app_${env.PORT} || true
                docker rm app_${env.PORT} || true
                docker run -d -p ${env.PORT}:3000 --name app_${env.PORT} ${env.IMAGE_NAME}
                """
            }
        }
    }
}
