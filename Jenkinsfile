pipeline {
    agent any
    environment {
        COMPOSE_IMAGE_TAG = "react-app:${env.BRANCH_NAME}-${env.BUILD_NUMBER}"
    }
    triggers {
        // Trigger pipeline on pull request events
        githubPullRequest()
    }
    stages {
        stage('Checkout') {
            steps {
                // Checkout the code from the PR branch or master
                checkout scm
            }
        }
        stage('Build with Docker Compose') {
            steps {
                script {
                    // Build the Docker image using docker-compose
                    sh 'docker-compose build'
                }
            }
        }
        stage('Test') {
            steps {
                // Run tests inside the built container
                script {
                    sh 'docker-compose run --rm react-app npm test'
                }
            }
        }
        stage('Deploy to Staging') {
            steps {
                // Start the service in detached mode using docker-compose
                script {
                    sh 'docker-compose up -d'
                }
                echo "Staging server is running at http://localhost:3000"
            }
        }
    }
    post {
        always {
            // Bring down the Docker Compose services
            script {
                sh 'docker-compose down'
            }
        }
        success {
            echo "Pull request deployment successful."
        }
        failure {
            echo "Pull request deployment failed."
        }
    }
}
