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

# Download dependencies (including annotation processors)
RUN ./mvnw dependency:go-offline -B

# Force rebuild to clear cache
# Copy lombok.config if it exists
COPY lombok.config* ./

# Copy source code
COPY src ./src

# Clean and build with annotation processing
# First compile to ensure Lombok generates getters/setters
RUN ./mvnw clean compile -DskipTests -Dmaven.compiler.proc=full -X 2>&1 | grep -i "lombok\|annotation\|processor" | head -20 || true
RUN ./mvnw package -DskipTests -Dmaven.compiler.proc=full

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
