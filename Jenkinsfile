pipeline {
    agent any

    parameters {
         string(name: 'tomcat_stage', defaultValue: '34.203.77.33', description: 'Staging Server')
         string(name: 'tomcat_prod', defaultValue: '54.174.208.127', description: 'Production Server')
    }

    triggers {
         pollSCM('* * * * *')
     }


stages{
        stage('Build'){
            steps {
                bat 'mvn clean package'
            }
            post {
                success {
                    echo 'Now Archiving...'
                    archiveArtifacts artifacts: '**/target/*.war'
                }
            }
        }
 
        stage ('Deployments'){
            parallel{
                stage ('Deploy to Staging'){
                    steps {
					
							sh "scp -i c:/users/cigar621/.ssh/jenkinssss.pem **/target/*.war ec2-user@${params.tomcat_stage}:/home/ec2-user/apache-tomcat-9.0.37/webapps"

                        
                    }
                }
 
                stage ("Deploy to Production"){
                    steps {
				
    						sh "scp i c:/users/cigar621/.ssh/jenkinssss.pem **/target/*.war ec2-user@${params.tomcat_prod}:/home/ec2-user/apache-tomcat-9.0.37/webapps"
						
                        
                    }
                }
            }
        }
    }
}
