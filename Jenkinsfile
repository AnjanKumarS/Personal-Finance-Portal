pipeline {
    agent any

    environment {
        IMAGE_NAME = "finance-portal:latest"
    }

    stages {
        stage('Clone Repository') {
            steps {
                git url: 'https://github.com/AnjanKumarS/Personal-Finance-Portal.git', branch: 'main'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $IMAGE_NAME .'
            }
        }

        stage('Push to Local Docker (Optional)') {
            steps {
                echo "Using local Docker. Skipping push."
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                sh '''
                kubectl apply -f k8s/namespace.yaml
                kubectl apply -f k8s/configmap.yaml
                kubectl apply -f k8s/secret.yaml
                kubectl apply -f k8s/persistent-volume.yaml
                kubectl apply -f k8s/persistent-volume-claim.yaml
                kubectl apply -f k8s/deployment.yaml
                kubectl apply -f k8s/service.yaml
                kubectl apply -f k8s/ingress.yaml
                '''
            }
        }

        stage('Check Pod Status') {
            steps {
                sh 'kubectl get pods -n finance-portal'
            }
        }
    }
}
