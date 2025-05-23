pipeline {
    agent any
    environment {
        DOCKERHUB_CREDENTIALS = credentials('Docker-Hub-Credentials')
        IMAGE_NAME = "kemiagbabiaka/java-web-project3"
    }
    stages {
        stage('Checkout') {
            steps {
                git branch: 'project-3', url: 'https://github.com/zeebabes/javawebproject.git'
            }
        }
        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $IMAGE_NAME:latest .'
            }
        }
        stage('Push to DockerHub') {
            steps {
                sh "echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin"
                sh 'docker push $IMAGE_NAME:latest'
            }
        }
        stage('Deploy to Kubernetes') {
            steps {
                withCredentials([file(credentialsId: 'kubeconfig-prod', variable: 'KUBECONFIG')]) {
                    sh 'kubectl apply -f deployment.yaml'
                }
            }
        }
    }
}
 
 
