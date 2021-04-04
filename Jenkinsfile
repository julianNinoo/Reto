pipeline {
  environment {
    imagename = "julian:1.0.1"
    registryCredential = 'julian-dockerhub'
    dockerImage = ''
  }
  agent any
  stages {
    stage('Cloning Git') {
      steps {
        git([url: 'https://github.com/julianNinoo/RetoAddi.git', branch: 'master', credentialsId: 'git'])

      }
    }
   
 
    stage('remove container') {
      steps{
        script {
          sh 'docker stop $(docker ps -a -q)'
          sh 'docker rm $(docker ps -a -q)'
         }
       }
    }  

    stage('remove images') {
      steps{
        script {
          sh 'docker rmi $(docker images -q)'
          }
        }
      }
    
    stage('Building image') {
      steps{
        script {
//	  sh 'cd /home/juliannino/'
	  sh 'docker build -t julian:1.0.1 .'
        }
      }
    }


    stage('Deploy images') {
      steps{
        sh 'docker run -d -p 5000:5000 julian:1.0.1'
      }
    }
  }
}
