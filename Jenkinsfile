node {
  def mvnHome
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
  stage('Sonar') {
    // sh "mvn sonar:sonar -Dsonar.host.url=http://54.210.94.151 -Dsonar.login=ac43b5dfe476d4e254ef52ead44639d6a8ef1a4e"

    withSonarQubeEnv('sonarqube@alchemy') {
      sh 'mvn  sonar:sonar'
    }
  }
  stage("Quality Gate") {
    timeout(time: 1, unit: 'HOURS') { // Just in case something goes wrong, pipeline will be killed after a timeout
      def qg = waitForQualityGate() // Reuse taskId previously collected by withSonarQubeEnv
      if (qg.status != 'OK') {
        error "Pipeline aborted due to quality gate failure: ${qg.status}"
      }
    }
  }

 // stage('Deploy'){sshPublisher(publishers: [sshPublisherDesc(configName: 'ec-2-deploy', transfers: [sshTransfer(excludes: '', execCommand: 'nohup java -jar ~/deploypipeprod/$BUILD_NUMBER/spring-boot-sample-web-mustache-2.0.1.RELEASE.jar  &', execTimeout: 120000, flatten: false, makeEmptyDirs: false, noDefaultExcludes: false, patternSeparator: '[, ]+', remoteDirectory: 'deploypipeprod/$BUILD_NUMBER', remoteDirectorySDF: false, removePrefix: 'target', sourceFiles: 'target/*.jar')], usePromotionTimestamp: false, useWorkspaceInPromotion: false, verbose: false)])
   //   }
   
}
