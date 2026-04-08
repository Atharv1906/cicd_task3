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

        stage('Set Environment') {
            steps {
                script {
                    if (params.ENV == 'main') {
                        env.IMAGE_NAME = "nodemain:v1.0"
                        env.PORT = "3000"
                    } else {
                        env.IMAGE_NAME = "nodedev:v1.0"
                        env.PORT = "3001"
                    }

                    echo "Branch: ${params.ENV}"
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
