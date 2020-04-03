pipeline {
   agent any
node ('docker-gcp') {
   stages {
      stage('Build') {
         steps {
            //sh "docker rm -f  \$(docker ps -a -q)"
            // sh "docker rm --force testing2"
            sh "docker-compose -f /var/lib/jenkins/workspace/web-docker1/docker-compose.yml up -d --build"
         }
      }
   }
 }
}
