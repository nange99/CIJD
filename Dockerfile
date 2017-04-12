FROM daocloud.io/library/ubuntu:latest

MAINTAINER Silva Song "silva.song@aliyun.com"


#安装JDK

RUN apt-get update
RUN apt-get install -y openjdk-8-jdk && apt-get install -y wget

#安装tomcat

RUN mkdir /var/tmp/tomcat
RUN wget -P /var/tmp/tomcat http://mirror.bit.edu.cn/apache/tomcat/tomcat-8/v8.0.43/bin/apache-tomcat-8.0.43.tar.gz
RUN tar xzf /var/tmp/tomcat/apache-tomcat-8.0.43.tar.gz -C /var/tmp/tomcat
RUN rm -rf /var/tmp/tomcat/apache-tomcat-8.0.43.tar.gz 

#安装maven

RUN mkdir /var/tmp/maven
RUN wget -P /var/tmp/maven http://apache.fayea.com/maven/maven-3/3.5.0/binaries/apache-maven-3.5.0-bin.tar.gz
RUN tar xzf /var/tmp/maven/apache-maven-3.5.0-bin.tar.gz -C /var/tmp/maven
RUN rm -rf /var/tmp/maven/apache-maven-3.5.0-bin.tar.gz
#设置maven环境变量

ENV MAVEN_HOME=/var/tmp/maven/apache-maven-3.5.0

ENV PATH=$MAVEN_HOME/bin:$PATH




RUN mkdir /var/tmp/webapp
ADD ./ /var/tmp/webapp

RUN cd /var/tmp/webapp && mvn package && cp /var/tmp/webapp/target/CIJD.war /var/tmp/tomcat/apache-tomcat-8.0.43/webapps

EXPOSE 8808


CMD ["./var/tmp/tomcat/apache-tomcat-8.0.43/bin/catalina.sh","run"]

