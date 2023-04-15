pipeline {
  agent any
  options {
    buildDiscarder(logRotator(numToKeepStr: '5'))
  }
  environment {
    DOCKERHUB_CREDENTIALS = credentials('dockerhub')
  }
  stages {
    stage('Build image for php-todo-app') {
      steps {
        sh 'docker build -t stlng/php-todo-master:0.0.1 .'
      }
    }
    stage('Login to docker hub') {
      steps {
        sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
      }
    }
    stage('Push docker image to docker hub registry') {
      steps {
        sh 'docker push stlng/php-todo-master:0.0.1'
      }
    }
  }
  post {
    always {
      sh 'docker logout'
    }
  }
  
}