pipeline {
    agent any

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
                git branch: params.ENV, url: 'https://github.com/<your-username>/cicd-pipeline.git'
            }
        }

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
                }
            }
        }

        stage('Deploy') {
            steps {
                sh """
                docker stop app_${PORT} || true
                docker rm app_${PORT} || true
                docker run -d -p ${PORT}:3000 --name app_${PORT} ${IMAGE_NAME}
                """
            }
        }
    }
}
