pipeline {
    agent any

    environment {
        DOCKER_HUB_USER = 'kemiagbabiaka'
        IMAGE_NAME = 'java-web-project3'
        KUBECONFIG_CREDENTIAL_ID = 'kubeconfig-secret' // store your kubeconfig here
    }

    stages {
        stage('Clone Repo') {
            steps {
                git branch: 'project-3', url: 'https://github.com/zeebabes/javawebproject.git'
            }
        }

        stage('Build & Rename WAR') {
            steps {
                sh '''
                  mvn clean package -DskipTests
                  mv target/*.war target/ROOT.war
                '''
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
                withCredentials([usernamePassword(credentialsId: 'docker-hub-cred', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh '''
                      echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin
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
