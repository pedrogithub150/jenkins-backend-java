FROM openjdk:16-jdk-alpine
COPY book/target/*.jar /app/app.jar
ENTRYPOINT ["java","-jar","/app/app.jar"]