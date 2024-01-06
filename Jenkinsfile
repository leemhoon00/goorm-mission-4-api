pipeline {
    agent any
    environment {
        ACCOUNT_ID = env.ACCOUNT_ID
    }
    stages {
        stage('Image Build') {
            steps {
                sh """
                    echo $ACCOUNT_ID
                """
            }
        }
    }
}