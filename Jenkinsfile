pipeline {
    agent any

    environment {
        IMAGE_NAME = 'my-docker-image'  // Name of the Docker image
        IMAGE_TAG = 'latest'            // Tag for the Docker image
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build') {
            steps {
                echo 'Building the project...'
                
                // Build Docker image using Windows batch command
                script {
                     bat 'docker --version'
                    bat 'docker build -t ${IMAGE_NAME}:${IMAGE_TAG} .'
                }
            }
        }

        stage('Deploy') {
            steps {
                echo 'Deploying the project...'

                // Run Docker container from the built image
                script {
                    bat 'docker run -d --name my-container ${IMAGE_NAME}:${IMAGE_TAG}'
                }
            }
        }
    }

    post {
        always {
            echo 'This will run after any stage completes.'

            // Clean up Docker containers and images after deployment
            script {
                bat 'docker stop my-container || true'
                bat 'docker rm my-container || true'
                bat 'docker rmi ${IMAGE_NAME}:${IMAGE_TAG} || true'
            }
        }
    }
}
