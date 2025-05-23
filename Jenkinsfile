pipeline {
    agent any

    environment {
        DOCKER_HUB_USER = 'dockerhub-creds' // matched the credentialId used in withCredentials
        IMAGE_NAME = 'kemiagbabiaka/java-web-project3'
        KUBECONFIG_CREDENTIAL_ID = 'kubeconfig-secret' // store your kubeconfig here
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
                        if [ $? -ne 0 ]; then
                            echo "Docker login failed"
                            exit 1
                        fi

                        docker push ${DOCKER_HUB_USER}/${IMAGE_NAME}:latest

                        # Optional debug
                        # docker images
                        # docker logout
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
