pipeline {
    agent any

stages {
    stage('Build') {
        steps {
            echo 'Getting package from Git...'
            sh "git clone https://github.com/ouwdash/spring-petclinic "
            echo "WHICH DIR AM I IN?"
            sh "echo $PWD"
            }
        }
        stage('Test') {
            steps {
                echo 'Testing..'
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying....'
            }
        }
    }
}
