# Giai đoạn 1: Dùng Maven + JDK 21 để đóng gói code thành file LTWeb.war
FROM maven:3.9.9-eclipse-temurin-21 AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

# Giai đoạn 2: Chạy file WAR trên Apache Tomcat 11 (tương thích Jakarta EE 10)
FROM tomcat:11.0-jdk21-temurin
RUN rm -rf /usr/local/tomcat/webapps/*
# Copy thành ROOT.war để chạy thẳng trên trang chủ của Render
COPY --from=build /app/target/*.war /usr/local/tomcat/webapps/ROOT.war
EXPOSE 8080
CMD ["catalina.sh", "run"]