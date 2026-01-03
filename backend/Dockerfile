# Build stage
FROM eclipse-temurin:21-jdk AS build
LABEL maintainer="codeamigos7@gmail.com"
WORKDIR /app

# Copy Maven wrapper and pom.xml
COPY mvnw .
COPY mvnw.cmd .
COPY .mvn .mvn
COPY pom.xml .

# Make mvnw executable
RUN chmod +x mvnw

# Download dependencies
RUN ./mvnw dependency:go-offline -B

# Copy source code
COPY src ./src

# Build the application with verbose logging to debug Lombok
RUN ./mvnw clean compile -X 2>&1 | head -100 || true
RUN ./mvnw clean package -DskipTests -U

# Runtime stage
FROM eclipse-temurin:21-jre
LABEL maintainer="codeamigos7@gmail.com"
WORKDIR /app

# Copy the JAR file from build stage
COPY --from=build /app/target/CodeAmigos--Backend-0.0.1-SNAPSHOT.jar /app/CodeAmigos--Backend.jar

# Note: .env file is NOT copied - environment variables are provided by Render/Railway/etc.

# Expose port
EXPOSE 8080

# Run the application
ENTRYPOINT ["java", "-jar", "CodeAmigos--Backend.jar"]
