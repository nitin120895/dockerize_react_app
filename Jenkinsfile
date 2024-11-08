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
        stage('Build') {
            steps {
                echo 'Building the project...'
                // Any command that may fail
                sh 'exit 1' // Simulate failure
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying the project...'
            }
        }
    }
    post {
        always {
            echo 'This will run after any stage completes.'
        }
    }
}
