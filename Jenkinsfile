pipeline {
    agent any
    stages {
        stage('Image Push') {
            steps {
                sh 'aws ecr get-login-password --region ap-northeast-2 | docker login --username AWS --password-stdin ${env.ACCOUNT_ID}.dkr.ecr.ap-northeast-2.amazonaws.com'
                sh 'docker image build -t ${env.ACCOUNT_ID}.dkr.ecr.ap-northeast-2.amazonaws.com/goorm-mission-4 .'
                sh 'docker image push ${env.ACCOUNT_ID}.dkr.ecr.ap-northeast-2.amazonaws.com/goorm-mission-4:latest'
            }
        }
        stage('Deploy') {
            steps {
                sh 'aws ecs update-service --cluster goorm-mission-4 --service goorm-mission-4 --force-new-deployment'
            }
        }
    }
}