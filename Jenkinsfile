pipeline {
    agent any

    stages {

        stage('Get Source') {
            steps {
                git url: 'https://github.com/rrddevops/bootcamp2.git', credentialsId: 'github', branch: 'main'
            }
        }

        stage('Docker Build Image') {
            steps {
                script {
                    dockerapp = docker.build("rodrigordavila/web-php-aws:${env.BUILD_ID}",
                      '-f Dockerfile .')
                }
            }
        }

        stage('Docker Push Image') {
            steps {
                script {
                        docker.withRegistry('https://registry.hub.docker.com', 'dockerhub') {
                        dockerapp.push('latest')
                        dockerapp.push("${env.BUILD_ID}")
                    }
                }
            }
        }

        stage('Deploy Kubernetes') {
            agent {
                kubernetes {
                    cloud 'kubernetes'
                }
            }
            environment {
                tag_version = "${env.BUILD_ID}"
            }

            steps {
                sh 'sed -i "s/{{tag}}/$tag_version/g" ./k8s/deployments.yaml'
                sh 'cat ./k8s/deployments.yaml'
                kubernetesDeploy(configs: '**/k8s/**', kubeconfigId: 'kubeconfig')
            }
        }
    }
}