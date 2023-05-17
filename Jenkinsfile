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
                script {
                    sh ('docker compose -f todo.yml  up -d')
            }
        }
    }
        stage('Test image') {
            stages {
                    stage('testing endpoint') {
                        steps {
                            httpRequest url:'http://localhost:8000',
                            validResponseCodes:'200'
                        }
                    }

                    stage('shutting down app') {
                        steps {
                            sh 'docker compose -f todo.yml down'
                        }
                    }                    
                }
            }

        stage('Login to docker hub') {
            steps {
                sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
            }
        }
        stage('Push docker image to docker hub registry') {
            steps {
                sh ('docker push stlng/php-todo-${BRANCH_NAME}:${BUILD_NUMBER}')
            }
        }
    }       
    post {
        always {
            script {
                sh 'docker logout',
                sh 'docker system prune -f -a'
                cleanWs()
            }
        }
    }
}