FROM maven:3.9-eclipse-temurin-17 AS builder

WORKDIR /app

COPY pom.xml ./
RUN mvn -B -q dependency:go-offline

COPY src ./src
RUN mvn -B -q -DskipTests package

FROM eclipse-temurin:17-jre

WORKDIR /app

RUN apt-get update \
    && apt-get install -y --no-install-recommends wget \
    && rm -rf /var/lib/apt/lists/*

RUN groupadd --system yanma408 && useradd --system --gid yanma408 yanma408

COPY --from=builder /app/target/server-*.jar /app/app.jar

USER yanma408

EXPOSE 18082

ENTRYPOINT ["sh", "-c", "java ${JAVA_OPTS:-} -jar /app/app.jar"]
