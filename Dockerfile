FROM maven:3.8.3-openjdk-17 as builder

# Copy local code to the container image.
WORKDIR /app
COPY pom.xml .
COPY src ./src


RUN mvn package -DskipTests

FROM openjdk:11

COPY --from=builder /app/target/spring*.jar /spring-web-sample.jar

CMD ["java", "-Djava.security.egd=file:/dev/./urandom", "-jar", "/spring-web-sample.jar"]
