 
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
        stage('Build') {
            parallel {
                stage('Maven build') {
                    steps {
                        sh "mvn clean install"    
                    }
                }
                stage('Checkstyle') {
                    steps {
                        sh "mvn checkstyle:checkstyle"
                        checkstyle canComputeNew: false, defaultEncoding: '', healthy: '', pattern: 'target/checkstyle-result.xml.', unHealthy: ''
                        }
                    }
                }
            }
         stage('Build Docker Image'){
            steps{
               echo "Packaging..."
               sh "sudo docker build -t sakshigawande12/hello-world:${GIT_BRANCH}-${GIT_COMMIT} ."
            }
         }
         stage('Push Docker Image'){
            steps{
             withCredentials([string(credentialsId: 'dockerPwd', variable: 'dockerPwd')]) {
                    sh "sudo docker login -u sakshigawande12 -p ${dockerPwd} "
                  }
               sh "sudo docker push sakshigawande12/hello-world:${GIT_BRANCH}-${GIT_COMMIT}"
            }
         }
         stage('Build status to github') {
             steps {
            sh label: '', script: '''curl "https://api.GitHub.com/repos/sakshigawande12/spring-unit-testing-with-junit-and-mockito-master/statuses/$GIT_COMMIT?access_token=981699c079fec7d12baab41e026dccd8634db855" \\
                         -H "Content-Type: application/json" \\
                         -X POST \\
                        -d "{\\"state\\": \\"success\\",\\"context\\": \\"continuous-integration/jenkins\\", \\"description\\": \\"Jenkins\\", \\"target_url\\": \\"http://34.72.39.165:8080/job/multi-branch-pipeline/$BUILD_NUMBER/console\\"}"
                       '''
            }
         }
         stage('sanity check'){
             steps{
                input("does the project  is ready to deploy ?")
             }
         }
         stage('Deploy to test'){
             steps {
               dir('deployment'){ //do this in the deployment directory!
                  echo 'Deploying to test'
                sh 'ansible-playbook -i /etc/ansible/hosts /etc/ansible/main.yml'
               }
             }
         }
      }
   }
