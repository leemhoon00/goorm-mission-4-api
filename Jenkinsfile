pipeline {
    agent any
    stages {
        stage('Image Build') {
            steps {
                sh 'echo ${env.ACCOUNT_ID}'
                // sh 'docker image build -t ${env.ACCOUNT_ID}.dkr.ecr.ap-northeast-2.amazonaws.com/goorm-mission-4 .'
                // sh 'docker image ls'
            }
        }
        stage('Clean') {
            steps {
                sh 'docker image rm ${env.ACCOUNT_ID}.dkr.ecr.ap-northeast-2.amazonaws.com/goorm-mission-4:latest'
            }
        }
        // stage('Deploy') {
        //     steps {
        //         sh 'aws ecs update-service --cluster goorm-mission-4 --service goorm-mission-4 --force-new-deployment'
        //     }
        // }
    }
}