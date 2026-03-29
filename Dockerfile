# STAGE 1: Build
FROM eclipse-temurin:21-jdk AS build
WORKDIR /app
COPY . .
RUN chmod +x mvnw
# Ensure we build a clean war file
RUN ./mvnw clean package -DskipTests

# STAGE 2: Run
FROM eclipse-temurin:21-jdk
WORKDIR /app

# Copy whatever .war was built into the current directory as 'app.war'
COPY --from=build /app/target/*.war /app/app.war

EXPOSE 8080

# Run the app directly from the root of /app
CMD ["java", "-XX:MaxRAMPercentage=80", "-jar", "/app/app.war"]
