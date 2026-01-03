FROM eclipse-temurin:21-jdk AS build
LABEL maintainer="codeamigos7@gmail.com"
WORKDIR /app

# Copy Maven wrapper and pom.xml
COPY mvnw .
COPY mvnw.cmd .
COPY .mvn .mvn
COPY pom.xml .

# Download dependencies
RUN ./mvnw dependency:go-offline -B

# Copy source code
COPY src ./src

# Build the application
RUN ./mvnw clean package -DskipTests

# Runtime stage
FROM eclipse-temurin:21-jre
LABEL maintainer="codeamigos7@gmail.com"
WORKDIR /app

# Copy the JAR file from build stage
COPY --from=build /app/target/CodeAmigos--Backend-0.0.1-SNAPSHOT.jar /app/CodeAmigos--Backend.jar

# Copy .env file
COPY .env .env

# Expose port
EXPOSE 8080

# Run the application
ENTRYPOINT ["java", "-jar", "CodeAmigos--Backend.jar"]
