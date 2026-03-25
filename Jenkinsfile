pipeline {
    agent any
	environment {
        IMAGE_NAME = 'demo-app'
        IMAGE_TAG = "${BUILD_NUMBER}"
		ARTIFACTORY_URL="http://host.containers.internal:8082/artifactory/docker-local"
	    ARTIFACTORY_CREDS = "artifactory-creds"
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
                sh 'podman --version'     
            }
        }
        stage('Build') {
            steps {
				sh 'cd /var/jenkins_home/workspace/demo_pipeline'
                sh 'podman build -t ${IMAGE_NAME}:${IMAGE_TAG} .'   //podman build command builds the image by tagging image with name and buildnumber, . sends all files to Daemon to execute
                sh 'podman save ${IMAGE_NAME}:${IMAGE_TAG} -o ${IMAGE_NAME}-${IMAGE_TAG}.tar'
				sh 'podman images'
            }
        }
		stage('Upload to Artifactory') {
		    steps {
				echo "${ARTIFACTORY_URL}"
                withCredentials([usernamePassword(
                    credentialsId: "${ARTIFACTORY_CREDS}",
                    usernameVariable: 'ART_USER',
                    passwordVariable: 'ART_PASS'
                )]) { 
					//uploadig image.tar file  to artifactory oss repo
                    sh '''
                          curl -u "\${ART_USER}:\${ART_PASS}" \
                          -T ${IMAGE_NAME}-${IMAGE_TAG}.tar \
                          "${ARTIFACTORY_URL}"
                    '''
					//password is securely piped for sign in ART_PASS is local inside the function
					echo "uploaded the image"
                }
            }
        }
		
    }
}
