pipeline {
    agent any

    environment {
        DOCKER_HUB_USER = 'docker-hub-cred' // Used in docker build/tag
        IMAGE_NAME = 'kemiagbabiaka/java-web-project3'
        KUBECONFIG_CREDENTIAL_ID = 'kubeconfig-prod' // Jenkins secret file ID
    }

    stages {
        stage('Clone Repo') {
            steps {
                git branch: 'project-3', url: 'https://github.com/zeebabes/javawebproject.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    docker.build("${DOCKER_HUB_USER}/${IMAGE_NAME}:latest")
                }
            }
        }

        stage('Push to DockerHub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh '''
                        echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
                        docker push ${DOCKER_HUB_USER}/${IMAGE_NAME}:latest
                    '''
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                withCredentials([file(credentialsId: "${KUBECONFIG_CREDENTIAL_ID}", variable: 'KUBECONFIG')]) {
                    sh '''
                        export KUBECONFIG=$KUBECONFIG
                        kubectl apply -f k8s/deployment.yaml
                        kubectl apply -f k8s/service.yaml
                    '''
                }
            }
        }
    }
}


