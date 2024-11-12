pipeline {
    agent any

    environment {
        IMAGE_NAME = 'my-docker-image'
        IMAGE_TAG = 'latest'
    }

    stages {
        stage('Checkout') {
          steps {
                script {
                    // If this is a PR, checkout the source branch of the PR (feature branch)
                    if (env.CHANGE_BRANCH) {
                        echo "Checking out the PR source branch: ${env.CHANGE_BRANCH}"
                        checkout scm: [
                            $class: 'GitSCM',
                            branches: [[name: "origin/${env.CHANGE_BRANCH}"]],
                            userRemoteConfigs: [[url: 'https://github.com/your-repo.git']]
                        ]
                    } else {
                        // If not a PR (direct push), check out the branch from which the job was triggered (e.g., main)
                        echo "Not a PR, checking out the branch from which the job was triggered (e.g., main)"
                        checkout scm
                    }
                }
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
