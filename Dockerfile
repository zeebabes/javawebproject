# Stage 1 - Build the app
FROM maven:3.9.4-eclipse-temurin-17 as builder
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests \
    && mv target/*.war target/ROOT.war

# Stage 2 - Deploy to Tomcat
FROM tomcat:9.0
COPY --from=builder /app/target/ROOT.war /usr/local/tomcat/webapps/
EXPOSE 8080
CMD ["catalina.sh", "run"]

