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
                sh 'docker build -t rodrigordavila/web-php-aws:latest .'
                sh 'docker build -t rodrigordavila/web-php-aws:$BUILD_NUMBER .'
            }
        }

        stage('Docker Push Image') {
            steps {
                sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
            }
        }

        stage('Push') {
			steps {
				sh 'docker push rodrigordavila/web-php-aws:latest'
                sh 'docker push rodrigordavila/web-php-aws:$BUILD_NUMBER'
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