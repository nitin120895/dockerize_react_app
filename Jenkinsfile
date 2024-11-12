pipeline {
    agent any

    environment {
        IMAGE_NAME = 'my-docker-image'
        IMAGE_TAG = 'latest'
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

                // Build Docker image using Windows batch variables
                script {
                    bat 'docker build -t %IMAGE_NAME%:%IMAGE_TAG% .'
                }
            }
        }

        stage('Deploy') {
            steps {
                echo 'Deploying the project...'

                // Run Docker container using Windows batch variables
                script {
                    bat 'docker run -d --name my-container %IMAGE_NAME%:%IMAGE_TAG%'
                }
            }
        }
    }

    post {
        always {
            echo 'This will run after any stage completes.'
            
            // Clean up Docker containers and images
            script {
                bat 'docker stop my-container || true'
                bat 'docker rm my-container || true'
                bat 'docker rmi %IMAGE_NAME%:%IMAGE_TAG% || true'
            }
        }
    }
}
