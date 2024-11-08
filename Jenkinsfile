pipeline {
    agent any
    environment {
        DOCKER_IMAGE_NAME = "my-react-app" // Local Docker image name
        DOCKER_TAG = "${env.BRANCH_NAME}-${env.BUILD_ID}"
        DOCKER_NETWORK = "react_network"
    }

    stages {
        stage('Checkout Code') {
            steps {
                // Checkout the code from the PR branch or master
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Build Docker image locally using Dockerfile
                    sh 'docker build -t $DOCKER_IMAGE_NAME:$DOCKER_TAG .'
                }
            }
        }

        stage('Run Docker Container Locally') {
            steps {
                script {
                    // Run the Docker container using Docker Compose or directly
                    sh '''
                    docker network create $DOCKER_NETWORK || true
                    docker run -d --name react-app -p 8080:80 --network $DOCKER_NETWORK $DOCKER_IMAGE_NAME:$DOCKER_TAG
                    '''
                }
            }
        }

        stage('Test Docker Container (Optional)') {
            steps {
                script {
                    // Optionally, you can run tests on the container here
                    // sh 'docker exec react-app npm test'
                }
            }
        }

        stage('Clean up') {
            steps {
                script {
                    // Stop and remove the container after testing
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
            // Clean up Docker resources after each build
            sh 'docker system prune -f || true'
        }
    }
}
