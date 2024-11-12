pipeline {
    agent any

    environment {
        // Define Docker image name
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
 // Check Docker version to ensure it's available
        bat 'docker --version'
                // Build Docker image after the build process
                script {
                    // Build the Docker image and fail the pipeline if it fails
                    try {
                        sh 'docker build -t ${IMAGE_NAME}:${IMAGE_TAG} .'
                    } catch (Exception e) {
                        currentBuild.result = 'FAILURE'
                        throw e
                    }
                }
            }
        }
        
        stage('Deploy') {
            steps {
                echo 'Deploying the project...'

                // Run Docker container from the built image
                script {
                    // Run the Docker container and fail the pipeline if it fails
                    try {
                        sh 'docker run -d --name my-container ${IMAGE_NAME}:${IMAGE_TAG}'
                    } catch (Exception e) {
                        currentBuild.result = 'FAILURE'
                        throw e
                    }
                }
            }
        }
    }

    post {
        always {
            echo 'This will run after any stage completes.'
            
            // Clean up Docker containers and images if necessary
            script {
                // Stop and remove the container after deployment (if it was created)
                sh 'docker stop my-container || true'
                sh 'docker rm my-container || true'
                
                // Optionally remove the Docker image
                sh 'docker rmi ${IMAGE_NAME}:${IMAGE_TAG} || true'
            }
        }
    }
}
