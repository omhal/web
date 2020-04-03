pipeline {
   // agent any
node {
    echo "docker-gcp"
}
   stages {
      stage('Build') {
         steps {
            //sh "docker rm -f  \$(docker ps -a -q)"
            // sh "docker rm --force testing2"
            sh "docker-compose -f /home/xblack/gcp/workspace/docker-gcp/docker-compose.yml up -d --build"
         }
      }
   }
} 
