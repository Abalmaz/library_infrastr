pipeline {
    agent any
    stages {
        stage("test") {
            steps {
                script {
                    echo "Run some test..."
                }
            }
        }
        stage("build image") {
            steps {
                script {
                    echo "building..."
                    withCredentials([usernamePassword(credentialsId: 'docker-hub', passwordVariable: 'PASS', usernameVariable: 'USER')]){
                        sh 'docker --version'
                    }
                }
            }
        }
        stage("deploy") {
            steps {
                script {
                    echo "deploying..."
                }
            }
        }
    }
}
