pipeline {
  agent any

  environment {
    IMAGE_NAME = "srilekya/static-web-app"
    IMAGE_TAG  = "v3"
  }

  stages {

        stage('Checkout Code') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/Srilekya07/static-web-ci-cd.git'
            }
        }

  

    stage('Build Docker Image') {
      steps {
        sh '''
                docker build -t $IMAGE_NAME:$IMAGE_TAG .
                '''
      }
    }

    stage('Login to Docker Hub') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub-creds',
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
                )]) {
                    sh '''
                    echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
                    '''
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                sh '''
                docker push $IMAGE_NAME:$IMAGE_TAG
                '''
            }
        }
    }
}
