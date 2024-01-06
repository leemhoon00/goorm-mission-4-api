pipeline {
    agent any
    environment {
        ACCOUNT_ID = ${ACCOUNT_ID}
    }
    stages {
        stage('Image Build') {
            steps {
                sh """
                    echo "${ACCOUNT_ID}"
                """
            }
        }
    }
}