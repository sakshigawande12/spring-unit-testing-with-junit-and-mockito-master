 
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
  stage('B1') {
            steps {
     sh label: '', script: '''curl "https://api.GitHub.com/repos/sakshigawande12/spring-unit-testing-with-junit-and-mockito-master/statuses/$GIT_COMMIT?access_token=saksH@123" \\
  -H "Content-Type: application/json" \\
  -X POST \\
  -d "{\\"state\\": \\"success\\",\\"context\\": \\"continuous-integration/jenkins\\", \\"description\\": \\"Jenkins\\", \\"target_url\\": \\"http://34.72.39.165:8080/job/multi-branch-pipeline/$BUILD_NUMBER/console\\"}"'''
    }
   }
  stage('B1') {
            steps {
     sh label: '', script: '''curl "https://api.GitHub.com/repos/sakshigawande12/spring-unit-testing-with-junit-and-mockito-master/statuses/$GIT_COMMIT?access_token=saksH@123" \\
  -H "Content-Type: application/json" \\
  -X POST \\
  -d "{\\"state\\": \\"failure\\",\\"context\\": \\"continuous-integration/jenkins\\", \\"description\\": \\"Jenkins\\", \\"target_url\\": \\"http://34.72.39.165:8080/job/multi-branch-pipeline/$BUILD_NUMBER/console\\"}"'''
    }
   }

     
    }
 post{
  success{
  githubNotify account: 'sakshigawande12', context: 'build-status', credentialsId: '', description: 'failed', gitApiUrl: '', repo: 'HelloWorld', sha: "${GIT_COMMIT}", status: 'FAILURE', targetUrl: 'http://34.72.39.165:8080/'
  }
}
}
