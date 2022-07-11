FROM openjdk:11
EXPOSE 8088
ADD target/Timesheet-spring-boot-core-data-jpa-mvc-REST-1-0.0.1-SNAPSHOT.war timesheet-1.0.war
ENTRYPOINT ["java", "-jar", "/timesheet-1.0.war" ]