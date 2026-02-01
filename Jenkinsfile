pipeline {
  agent any

  environment {
    IMAGE_NAME = "srilekya/static-web-app"
  }

  stages {
    stage('Checkout SCM') {
      steps {
        checkout scm
      }
    }

    stage('SonarQube Scan') {
  environment {
    SCANNER_HOME = tool 'sonar-scanner'
  }
  steps {
    withSonarQubeEnv('sonarqube-server') {
      sh '''
        $SCANNER_HOME/bin/sonar-scanner
      '''
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

