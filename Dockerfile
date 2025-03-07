# Use Maven to build the project
FROM maven:3.9.4-eclipse-temurin-8 AS build

# Set the working directory inside the container
WORKDIR /app

# Copy the Maven project files
COPY pom.xml ./
COPY src ./src

# Build the WAR file
RUN mvn clean package

# Use an official Tomcat image to run the WAR
FROM tomcat:9.0-jdk8-openjdk

# Remove the default ROOT application
RUN rm -rf /usr/local/tomcat/webapps/ROOT

# Copy the built WAR file to Tomcat's webapps directory
COPY --from=build /app/target/24_Rest_App01.war /usr/local/tomcat/webapps/ROOT.war

# Expose port 8085
EXPOSE 8085

# Start Tomcat server
CMD ["catalina.sh", "run"]
