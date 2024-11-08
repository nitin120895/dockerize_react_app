pipeline {
    agent any

    environment {
        DOCKER_IMAGE_NAME = "my-react-app"
        DOCKER_TAG = "${env.BRANCH_NAME}-${env.BUILD_ID}"
        DOCKER_NETWORK = "react_network"
    }

    stages {
        stage('Checkout Code') {
            steps {
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    echo "Building Docker image..."
                    try {
                        sh 'docker build -t $DOCKER_IMAGE_NAME:$DOCKER_TAG . || exit 1'
                        echo "Docker image built: $DOCKER_IMAGE_NAME:$DOCKER_TAG"
                    } catch (Exception e) {
                        echo "Docker build failed: ${e.getMessage()}"
                        throw e
                    }
                }
            }
        }

        stage('Run Docker Container Locally') {
            steps {
                script {
                    echo "Creating Docker network..."
                    try {
                        sh 'docker network create $DOCKER_NETWORK || true'
                    } catch (Exception e) {
                        echo "Docker network creation failed: ${e.getMessage()}"
                    }

                    echo "Running Docker container..."
                    try {
                        sh '''
                        docker run -d --name react-app -p 8080:80 --network $DOCKER_NETWORK $DOCKER_IMAGE_NAME:$DOCKER_TAG
                        '''
                    } catch (Exception e) {
                        echo "Docker run failed: ${e.getMessage()}"
                        throw e
                    }

                    echo "Docker container is running."
                }
            }
        }

        stage('Clean up') {
            steps {
                script {
                    echo "Cleaning up Docker container..."
                    try {
                        sh 'docker stop react-app || true'
                        sh 'docker rm react-app || true'
                        sh 'docker rmi $DOCKER_IMAGE_NAME:$DOCKER_TAG || true'
                        sh 'docker network rm $DOCKER_NETWORK || true'
                    } catch (Exception e) {
                        echo "Error during cleanup: ${e.getMessage()}"
                    }
                }
            }
        }
    }

    post {
        always {
            echo "Cleaning up Docker resources..."
            try {
                sh 'docker system prune -f || true'
            } catch (Exception e) {
                echo "Docker system prune failed: ${e.getMessage()}"
            }
        }
    }
}
