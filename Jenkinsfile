pipeline {
    agent any
	environment {
        IMAGE_NAME = "demo-app"
        IMAGE_TAG = "${BUILD_NUMBER}"
    }
    stages {
        stage('Checkout') {     // Phase 1: Get code from GitHub
            steps {
                echo 'Cloning repo...'
                checkout scm      // Auto-clones your GitHub repo
            }
        }
        stage('Build') {
            steps {
				sh 'docker --version'
                sh 'docker build -t IMAGE_NAME:IMAGE_TAG .'   //podman build command builds the image by tagging image with name and buildnumber, . sends all files to Daemon to execute
                sh 'docker images | grep demo-app'
            }
        }
    }
}
