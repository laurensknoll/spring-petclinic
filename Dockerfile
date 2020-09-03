FROM openjdk:8-jdk AS build-env
WORKDIR /app
ADD . .

RUN ./mvnw package -Dmaven.test.skip=true

FROM gcr.io/distroless/java:8
WORKDIR /app
COPY --from=build-env /app/target/*.jar /app/app.jar
CMD ["app.jar"]