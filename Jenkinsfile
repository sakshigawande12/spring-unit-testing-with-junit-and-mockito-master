 
pipeline {
    agent any
 stages {       
         stage('Compile') {
             steps{
                         sh "mvn clean compile"
             }
      }
        stage('Test') {
            steps {
                echo "Testing..."
                sh "mvn test"

            }
        }
        stage('Package'){
            steps{
               echo "Packaging..."
               sh "mvn package"


            }
        }
        stage('Run') {
            steps {
                echo "Running..."
                sh "mvn validate"
            }
        }

      stage('Build Docker Image'){
            steps{
               echo "Packaging..."
               sh "sudo docker build -t knox-rest:${GIT_BRANCH}-${GIT_COMMIT} ."
            }
        }
        stage('Push Docker Image'){
            steps{
             withCredentials([string(credentialsId: 'dockerPwd', variable: 'dockerPwd')]) {
                    sh "sudo docker login -u sakshigawande12 -p ${dockerPwd} "
                  }
               sh "sudo docker push sakshigawande12/knolx-rest:2.0.0"
            }
        }

     
    }
}
