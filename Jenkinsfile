 
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
               sh "sudo docker build -t sakshigawande12/knox-rest:${GIT_BRANCH}-${GIT_COMMIT} ."
            }
        }
        stage('Push Docker Image'){
            steps{
             withCredentials([string(credentialsId: 'dockerPwd', variable: 'dockerPwd')]) {
                    sh "sudo docker login -u sakshigawande12 -p ${dockerPwd} "
                  }
               sh "sudo docker push sakshigawande12/knox-rest:${GIT_BRANCH}-${GIT_COMMIT}"
            }
        }

     
    }
 post{
  githubNotify account: 'sakshigawande12', context: 'build-status', credentialsId: '5f3f4be6-94a3-4991-8515-d8936cc4f147', description: 'failed', gitApiUrl: '', repo: 'HelloWorld', sha: "${GIT_COMMIT}", status: 'FAILURE', targetUrl: 'http://34.72.39.165:8080/'
 }
}
