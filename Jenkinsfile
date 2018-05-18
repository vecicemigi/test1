node {
  def mvnHome
  stage('Preparation') { // for display purposes

    git url: 'https://github.com/vecicemigi/test1.git'

  }
  stage('Build') {

    if (isUnix()) {
      sh "'mvn' clean package"
    } else {
      bat(/"${mvnHome}\bin\mvn" -Dmaven.test.failure.ignore clean package/)
    }
  }
  stage('Results') {
    junit '**/target/surefire-reports/TEST-*.xml'
    archive 'target/*.jar'
  }
  
 stage('Deploy') {
    
         sh "1.sh"
    
}

}
