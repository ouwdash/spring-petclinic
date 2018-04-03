

#FROM SCRATCH best preformance
#RUN useradd -c 'spring user' -m -d /home/spring -s /bin/bash spring
#RUN chown -R spring.spring /
#USER spring
#ENV HOME /home/spring

FROM ubuntu:latest
MAINTAINER Hans H. K. Shabastari "h.shabastari@gmail.com"
ENV PACKAGE_DIR /build
ENV PACKAGE_NAME spring-petclinic-2.0.0.BUILD-SNAPSHOT.jar

RUN apt-get update && apt-get install -y openjdk-8-jdk && rm -rf /var/lib/apt/lists/* && apt-get clean

#COPY PACKAGE
COPY spring-petclinic-2.0.0.BUILD-SNAPSHOT.jar $PACKAGE_DIR/$PACKAGE_NAME


#/home/spring/build/spring-petclinic-2.0.0.BUILD-SNAPSHOT.jar

#COPY JAVA
#COPY openjdk-8_8u151-b12-0ubuntu0.16.04.2.debian.tar.xz /home/spring/java/

EXPOSE 8080
# EXPOSE 3306 mysql
CMD java -jar $PACKAGE_DIR/$PACKAGE_NAME
