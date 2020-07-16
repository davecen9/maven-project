pipeline {
    agent any

    parameters {
         string(name: 'tomcat_stage', defaultValue: '34.203.77.33', description: 'Staging Server')
        //  string(name: 'tomcat_prod', defaultValue: '54.172.97.121', description: 'Production Server')
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
						sshagent(['jenkintest']) {
							// sh "scp -o StrictHostKeyChecking=no **/target/*.war ec2-user@${params.tomcat_dev}:/home/ec2-user/apache-tomcat-9.0.37/webapps"
							// sh "scp -o StrictHostKeyChecking=no **/target/*.war ec2-user@${params.tomcat_dev}:~"
							sh "ssh -v -o StrictHostKeyChecking=no ec2-user@${params.tomcat_stage}"
							echo "done.."
						}
                        // sh "ssh -v -i c:/users/cigar621/.ssh/jenkinssss.pem ec2-user@${params.tomcat_stage}"
                        
                    }
                }
 
                // stage ("Deploy to Production"){
                //     steps {
				// 		sshagent(['tomcat-demo']) {
    			// 			sh "scp -o StrictHostKeyChecking=no **/target/*.war ec2-user@${params.tomcat_prod}:/home/ec2-user/apache-tomcat-9.0.37/webapps"
				// 		}
                        
                //     }
                // }
            }
        }
    }
}
