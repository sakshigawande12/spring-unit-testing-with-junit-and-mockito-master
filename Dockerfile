FROM openjdk:jre-alpine

WORKDIR /java-example

CMD echo "updated dockerfile"

COPY target/unit-testing-0.0.1-SNAPSHOT.jar .

CMD ["java","-jar","unit-testing-0.0.1-SNAPSHOT.jar"]

