# Etapa 1: construir el WAR
FROM maven:3.8.5-openjdk-17 AS build

COPY . /app
WORKDIR /app
RUN mvn clean package -DskipTests

# Etapa 2: usar Tomcat para servir el WAR
FROM tomcat:9.0
RUN rm -rf /usr/local/tomcat/webapps/*
COPY --from=build /app/target/*.war /usr/local/tomcat/webapps/ROOT.war
EXPOSE 8080
CMD ["catalina.sh", "run"]