pipeline{

	agent any

	environment {
		DOCKERHUB_CREDENTIALS=credentials('dockerhub')
	}

	stages {

     	stage('clone repo') {
		    steps {
                // Get some code from a GitHub repository
                git url: 'https://github.com/rrddevops/bootcamp2.git', credentialsId: 'githubsec' ,branch: 'main'

          	}
	  	}

		stage('Build') {

			steps {
				sh 'docker build -t rodrigordavila/web-php-aws:latest .'
			}
		}

		stage('Login') {

			steps {
				sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
			}
		}

		stage('Push') {

			steps {
				sh 'docker push rodrigordavila/web-php-aws:latest'
			}
		}
	}

	post {
		always {
			sh 'docker logout'
		}
	}

}