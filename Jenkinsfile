pipeline {
    agent any
    stages {
        stage('Image Build') {
            steps {
                sh """
                    docker image build -t ${ACCOUNT_ID}.dkr.ecr.ap-northeast-2.amazonaws.com/goorm-mission-4 .
                    docker image ls
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