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
                        bat "scp -i c:\\users\\cigar621\\.ssh\\tomcat-demo.pem **/target/*.war ec2-user@${params.tomcat_dev}:/home/ec2-user/apache-tomcat-9.0.37/webapps"
                    }
                }

                stage ("Deploy to Production"){
                    steps {
                        bat "scp -i c:\\users\\cigar621\\.ssh\\tomcat-demo.pem **/target/*.war ec2-user@${params.tomcat_prod}:/home/ec2-user/apache-tomcat-9.0.37/webapps"
                    }
                }
            }
        }
    }
}