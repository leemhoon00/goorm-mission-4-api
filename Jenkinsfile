pipeline {
    agent any
    stages {
        stage('Image Build') {
            steps {
                sh """
                    docker image build -t ${ACCOUNT_ID}.dkr.ecr.ap-northeast-2.amazonaws.com/goorm-mission-4 .
                """
            }
        }

        stage('Push') {
            steps {
                sh """
                    aws ecr get-login-password --region ap-northeast-2 | docker login --username AWS --password-stdin ${ACCOUNT_ID}.dkr.ecr.ap-northeast-2.amazonaws.com
                    docker image push ${ACCOUNT_ID}.dkr.ecr.ap-northeast-2.amazonaws.com/goorm-mission-4
                """
            }
        }

        stage('Deploy') {
            steps {
                sh """
                    aws ecs update-service --cluster goorm-mission-4 --service goorm-mission-4 --force-new-deployment
                """
            }
        }

        stage('Clean') {
            steps {
                sh """
                    docker image rm ${ACCOUNT_ID}.dkr.ecr.ap-northeast-2.amazonaws.com/goorm-mission-4
                """
            }
        }
    }
}