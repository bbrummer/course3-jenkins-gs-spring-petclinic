FROM maven:3.9.5-amazoncorretto-17 AS build-env
WORKDIR /app
COPY pom.xml ./
RUN mvn dependency:go-offline
COPY . ./
RUN mvn -o package
RUN mvn -o verify

