pipeline {
    agent any
	environment {
        IMAGE_NAME = 'demo-app'
        IMAGE_TAG = "${BUILD_NUMBER}"
		ARTIFACTORY_REGISTRY = "localhost:8082/docker-local"
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
                sh 'podman images'
            }
        }
		stage('Login to Artifactory') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: "${ARTIFACTORY_CREDS}",
                    usernameVariable: 'ART_USER',
                    passwordVariable: 'ART_PASS'
                )]) {
                    sh '''
                        echo "$ART_PASS" | podman login localhost:8082 -u "$ART_USER" --password-stdin --tls-verify=false  
                    '''
					//password is securely piped for sign in ART_PASS is local inside the function
                }
            }
        }
		stage('Tag Image') {
            steps {
                sh "podman tag ${IMAGE_NAME}:${IMAGE_TAG} ${ARTIFACTORY_REGISTRY}/${IMAGE_NAME}:${IMAGE_TAG}"
            }
        }
		 stage('Push Image') {
            steps {
                sh "podman push ${ARTIFACTORY_REGISTRY}/${IMAGE_NAME}:${IMAGE_TAG} --tls-verify=false"
				echo "pushed image"
            }
        }
    }
}
