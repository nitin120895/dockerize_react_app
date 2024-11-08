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
                    sh 'docker build -t $DOCKER_IMAGE_NAME:$DOCKER_TAG .'
                    echo "Docker image built: $DOCKER_IMAGE_NAME:$DOCKER_TAG"
                }
            }
        }

        stage('Run Docker Container Locally') {
            steps {
                script {
                    echo "Running Docker container..."
                    sh '''
                    docker network create $DOCKER_NETWORK || true
                    docker run -d --name react-app -p 8080:80 --network $DOCKER_NETWORK $DOCKER_IMAGE_NAME:$DOCKER_TAG
                    '''
                    echo "Docker container is running."
                }
            }
        }

        stage('Clean up') {
            steps {
                script {
                    echo "Cleaning up Docker container..."
                    sh 'docker stop react-app || true'
                    sh 'docker rm react-app || true'
                    sh 'docker rmi $DOCKER_IMAGE_NAME:$DOCKER_TAG || true'
                    sh 'docker network rm $DOCKER_NETWORK || true'
                }
            }
        }
    }

    post {
        always {
            echo "Cleaning up Docker resources..."
            sh 'docker system prune -f || true'
        }
    }
}
