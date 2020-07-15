pipeline {
    agent any

    parameters {
         string(name: 'tomcat_dev', defaultValue: '100.25.17.253', description: 'Staging Server')
         string(name: 'tomcat_prod', defaultValue: '54.172.97.121', description: 'Production Server')
    }

    triggers {
         pollSCM('* * * * *')
     }

stages{
        stage('Build'){
            steps {
                sh 'mvn clean package'
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
                    	// sh "scp -i C:/Users/cigar621/.ssh/admin.pem **/target/*.war ec2-user@${params.tomcat_dev}:/home/ec2-user/apache-tomcat-9.0.37/webapps"
						bat "scp -i C:/Users/cigar621/.ssh/admin **/target/*.war ec2-user@${params.tomcat_dev}:/home/ec2-user/apache-tomcat-9.0.37/webapps"
				
					}
                }

                stage ("Deploy to Production"){
                    steps {
                        // sh "scp -i C:/Users/cigar621/.ssh/admin.pem **/target/*.war ec2-user@${params.tomcat_prod}:/home/ec2-user/apache-tomcat-9.0.37/webapps"
						bat "scp -i C:/Users/cigar621/.ssh/admin **/target/*.war ec2-user@${params.tomcat_prod}:/home/ec2-user/apache-tomcat-9.0.37/webapps"
						
                    }
                }
            }
        }
    }
}