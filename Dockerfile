# STAGE 1: Build
FROM eclipse-temurin:21-jdk AS build
WORKDIR /app
COPY . .
RUN chmod +x mvnw
# Build without the DB-hungry profile
RUN ./mvnw clean package -DskipTests

# STAGE 2: Run
FROM eclipse-temurin:21-jdk
WORKDIR /app

# Using a wildcard (*) to find the war file regardless of version (e.g., steve-2.0.war)
# and renaming it to 'steve.war' for the CMD to find easily.
COPY --from=build /app/target/*.war steve.war

EXPOSE 8080

# The Start Command
CMD ["java", "-XX:MaxRAMPercentage=85", "-jar", "steve.war"]
