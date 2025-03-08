# Используем официальный образ с JDK 22
FROM openjdk:22-jdk-slim as builder

# Устанавливаем Tomcat
FROM tomcat:9.0

# Копируем JDK 22 из образа builder в томкат-контейнер
COPY --from=builder /usr/local/openjdk-22 /usr/local/openjdk-22

# Устанавливаем переменную окружения для Java
ENV JAVA_HOME=/usr/local/openjdk-22
ENV PATH="${JAVA_HOME}/bin:${PATH}"

# Устанавливаем рабочую директорию в контейнере
WORKDIR /usr/local/tomcat

# Копируем WAR файл в директорию webapps
COPY ./target/Pazl.war /usr/local/tomcat/webapps/

# Открываем порт
EXPOSE 8484

# Запуск Tomcat
CMD ["catalina.sh", "run"]
