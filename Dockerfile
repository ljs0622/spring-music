FROM openjdk:8-jdk-alpine
MAINTAINER lgcnser

RUN mkdir deploy
COPY build/libs/*.jar /deploy/app.jar
RUN chmod +x deploy/app.jar

ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/deploy/app.jar","&"]
