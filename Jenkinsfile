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
		stage('Podman Test') {
            steps {
                sh 'ldd /usr/bin/podman'  # Shows all library dependencies
                sh 'podman --version'     
            }
        }
        stage('Build') {
            steps {
                sh 'podman build -t IMAGE_NAME:IMAGE_TAG .'   //podman build command builds the image by tagging image with name and buildnumber, . sends all files to Daemon to execute
                sh 'podman images'
            }
        }
    }
}
