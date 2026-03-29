# STAGE 1: Build the application
FROM eclipse-temurin:21-jdk AS build
WORKDIR /app
COPY . .
# Run the maven wrapper to build the .war file
RUN ./mvnw clean package -Pdocker -DskipTests

# STAGE 2: Run the application
FROM eclipse-temurin:21-jdk
WORKDIR /app

# Copy only the built .war file from the build stage
COPY --from=build /app/target/steve.war .

EXPOSE 8080

# Run the application
CMD ["java", "-XX:MaxRAMPercentage=85", "-jar", "steve.war"]
