pipeline {
    agent any

    environment {
        IMAGE_NAME = 'my-docker-image'
        IMAGE_TAG = 'latest'
    }

    stages {
        stage('Checkout') {
           if (env.CHANGE_BRANCH) {
                        echo "Checking out the PR source branch: ${env.CHANGE_BRANCH}"
                        checkout scm: [
                            $class: 'GitSCM',
                            branches: [[name: "origin/${env.CHANGE_BRANCH}"]],
                            userRemoteConfigs: [[url: 'https://github.com/nitin120895/dockerize_react_app.git']]
                        ]
                    } else {
                        // If not a PR (for example, directly pushing to the main branch), checkout the default branch
                        echo "Checking out the main branch"
                        checkout scm
                    }
        }

        stage('Build') {
            steps {
                echo 'Building the project...'

                // Build Docker image using Windows batch variables
                script {
                    bat 'docker --version'
                    bat 'docker build -t %IMAGE_NAME%:%IMAGE_TAG% .'
                }
            }
        }

        stage('Deploy') {
            steps {
                echo 'Deploying the project...'

                // Run Docker container using Windows batch variables
                script {
                    bat 'docker run -d -p 3001:80 --name my-container %IMAGE_NAME%:%IMAGE_TAG%'
                }
            }
        }
    }

    post {
        always {
            echo 'This will run after any stage completes.'
            
        }
    }
}
