pipeline {
    agent any
    environment {
        DOCKER_IMAGE_NAME = "react-app"
        PR_BRANCH_NAME = "${env.CHANGE_BRANCH ?: env.BRANCH_NAME}"  // Fallback to current branch for regular branches
        DOCKER_TAG = "${PR_BRANCH_NAME}"
        // Generate a dynamic port based on the PR branch name, e.g., by hashing the branch name or taking the first few chars
        DOCKER_PORT = "80${PR_BRANCH_NAME.hashCode() % 1000 + 1000}" // Creates a unique port based on branch name
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    echo "Building Docker image with tag: ${DOCKER_TAG}"
                    sh "docker-compose build --no-cache"
                }
            }
        }

        stage('Run Docker Compose') {
            steps {
                script {
                    echo "Running container on port: ${DOCKER_PORT}"
                    // Run the app with Docker Compose on the dynamically generated port
                    sh "docker-compose up -d"
                    sh "docker-compose ps"
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    echo "App deployed with Docker image tagged: ${DOCKER_TAG}"
                }
            }
        }
    }

    post {
        always {
            sh "docker-compose down"
        }
    }
}
