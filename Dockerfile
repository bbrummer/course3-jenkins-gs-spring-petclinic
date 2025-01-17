FROM maven:3.9.5-amazoncorretto-17 AS build
WORKDIR /app
COPY pom.xml ./
RUN mvn dependency:go-offline
COPY . ./
RUN mvn -o package
RUN mvn -o verify
FROM scratch AS artifact
WORKDIR /output
COPY --from=build /app/target/*.jar /output/
COPY --from=build /app/target/surefire-reports/TEST*.xml /output/surefire-reports/
COPY --from=build /app/target/*.exec /output/
COPY --from=build /app/target/classes/ /output/classes/
