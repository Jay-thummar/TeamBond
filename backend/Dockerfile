# Build stage
FROM maven:3.9.6-eclipse-temurin-17 AS build
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# Runtime stage
FROM eclipse-temurin:17-jre
LABEL maintainer="codeamigos7@gmail.com"
WORKDIR /app

# Copy the JAR file from build stage
COPY --from=build /app/target/CodeAmigos--Backend-0.0.1-SNAPSHOT.jar /app/CodeAmigos--Backend.jar

# Expose port
EXPOSE 8080

# Run the application
ENTRYPOINT ["java", "-jar", "CodeAmigos--Backend.jar"]
