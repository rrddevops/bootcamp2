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
                sh 'docker build -t rodrigordavila/web-php-aws:${env.BUILD_ID} .'
                sh 'docker build -t rodrigordavila/web-php-aws:latest .'
            }
        }

        stage('Docker Push Image') {
            steps {
                sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
                }
            }
        }

        stage('Push') {
			steps {
				sh 'docker push rodrigordavila/web-php-aws:latest'
                sh 'docker push rodrigordavila/web-php-aws:${env.BUILD_ID}'
			}
		}

        stage('Deploy Kubernetes') {
            steps {
                withAWS(credentials: 'aws-cred', region: 'us-east-1') {
                    script {
                        sh 'aws eks list-clusters'
                        sh 'aws eks update-kubeconfig --name bootcamp-dev-eks'
                        sh 'kubectl apply -f ./k8s/deployments.yaml'
                    }
                }
            }
        }
    }
}