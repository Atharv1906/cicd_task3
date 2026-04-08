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

        stage('Build Docker Image') {
            steps {
                sh "docker build -t ${env.IMAGE_NAME} ."
            }
        }

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
