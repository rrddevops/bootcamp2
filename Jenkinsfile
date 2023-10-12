pipeline {
    agent any
    
    environment {
		DOCKERHUB_CREDENTIALS=credentials('dockerhub')
	}

    stages {

        stage('Get Source') {
            steps {
                git url: 'https://github.com/rrddevops/bootcamp2.git', credentialsId: 'github', branch: 'main'
            }
        }

        stage('Docker Build Image') {
            steps {
                sh 'aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 929163871313.dkr.ecr.us-east-1.amazonaws.com'
                sh 'docker build -t demoapp/php .'
                sh 'docker tag demoapp/php:latest 929163871313.dkr.ecr.us-east-1.amazonaws.com/demoapp/php:latest'
                sh ''
            }
        }

        stage('Push') {
			steps {
				sh 'docker push 929163871313.dkr.ecr.us-east-1.amazonaws.com/demoapp/php:latest'
                sh 'docker push 929163871313.dkr.ecr.us-east-1.amazonaws.com/demoapp/php:$BUILD_NUMBER'
			}
		}

        stage('Deploy Kubernetes') {
            steps {
                withAWS(credentials: 'aws-cred', region: 'us-east-1') {
                    script {
                        sh 'aws eks list-clusters'
                        sh 'aws eks update-kubeconfig --name bootcamp-dev-eks'
                        sh 'sed -i "s/<TAG>/$BUILD_NUMBER/" ./k8s/deployments.yaml'
                        sh 'kubectl apply -f ./k8s/deployments.yaml'
                    }
                }
            }
        }
    }

    post {
		always {
			sh 'docker logout'
		}
	}
}