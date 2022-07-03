pipeline {
        agent any
environment {

    registry = "raouagara/devopstimesheet"
    registryCredential = 'dockerHub'
    nexusCredential = 'nexus_cred'
    dockerImage = ''

}
        tools {
            maven "maven"
        }
        stages{
                        stage ('Checkout') {
                                    steps {
                                         echo "Getting Project from Git";
                                         git "https://github.com/raoua97/DevOps_Timesheet.git"
            }
        }
        stage ('MVN CLEAN') {
            steps {
                echo "Maven Clean";
                sh 'mvn clean';
            }
        }
        stage ('MVN TEST') {
            steps {
                echo "Maven Test JUnit";
                sh 'mvn test';
            }
        }
                        stage('Sonar Analyse'){
                                steps{
                    sh "mvn sonar:sonar"
                  }
            }

        stage ('MVN PACKAGE') {
            steps {

                sh 'mvn package';
            }
        }
                stage ('MVN INSTALL') {
            steps {

                sh 'mvn install';
            }
        }
            stage('Nexus Deploy'){
                                steps{
                                        sh "mvn deploy"
                                }
                        }

                        stage('Building Image'){
                                steps{
                                        script{
                                                dockerImage = docker.build registry + ":$BUILD_NUMBER"
                                        }
                                }
                        }

                        stage('Deploy Image'){
                                steps{
                                        script{
                                                docker.withRegistry( '', registryCredential )
                        {dockerImage.push()}
                                        }
                           
                               }
                        post {
                           always {
                           emailext body: 'A Test EMail', recipientProviders: [[$class: 'DevelopersRecipientProvider'], [$class: 'RequesterRecipientProvider']], subject: 'Test'
        }
    }       
                        }
                    stage('publish docker to nexus') {
                      // TODO: If the last commit is already tagged, nothing to do
                         steps{
                                        script{
                                withDockerRegistry(credentialsId: 'nexus_cred', url: 'http://192.168.1.130:10082/repository/hub-dev/') {
        
                                 dockerImage.push ()
        }
    }                      
        }
  }
        
                        
                        
                                                 }
                        }

