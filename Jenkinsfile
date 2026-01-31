pipeline {
  agent any

  environment {
    IMAGE_NAME = "srilekya/static-web-app"
  }

  stages {
    stage('Checkout') {
      steps {
        git url: 'https://github.com/Srilekya07/static-web-ci-cd.git'
      }
    }

    stage('SonarQube Scan') {
      steps {
        withSonarQubeEnv('sonarqube-server') {
          sh 'sonar-scanner'
        }
      }
    }

    stage('Build Docker Image') {
      steps {
        sh 'docker build -t $IMAGE_NAME:latest .'
      }
    }

    stage('Push Docker Image') {
      steps {
        withCredentials([usernamePassword(
          credentialsId: 'dockerhub-creds',
          usernameVariable: 'USER',
          passwordVariable: 'PASS'
        )]) {
          sh '''
          echo $PASS | docker login -u $USER --password-stdin
          docker push $IMAGE_NAME:latest
          '''
        }
      }
    }
  }
}

