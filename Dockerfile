FROM tomcat:latest

ADD ./webapp/target/*.war /user/local/tomcat/webapps/

EXPOSE 8080

CMD ["catalina.sh","run"]