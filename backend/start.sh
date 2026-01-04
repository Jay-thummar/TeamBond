#!/bin/bash

# Build the application
./mvnw clean package -DskipTests

# Run the application
java -jar target/CodeAmigos--Backend-0.0.1-SNAPSHOT.jar





