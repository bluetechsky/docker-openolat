FROM debian:latest
MAINTAINER BlackRose01<appdev.blackrose@gmail.com>

ENV DOMAINNAME localhost
ENV OPENOLAT_VERSION 1555
ENV OPENOLAT_UPDATE false
ENV TOMCAT_VERSION 9.0.50
ENV TOMCAT_UPDATE false
ENV INSTALL_DIR /opt/openolat

ENV DB_TYPE postgresql
ENV DB_HOST host.docker.internal
ENV DB_PORT 5432
ENV DB_NAME openolatdocker
ENV DB_USER postgres
ENV DB_PASS postgres

# COPY database/mysql.xml /tmp/mysql.xml
# COPY database/postgresql.xml /tmp/postgresql.xml
# Hung added
COPY database/spring-jdbc-5.3.8.jar /tmp/spring-jdbc-5.3.8.jar
COPY database/postgresql-42.2.22.jar /tmp/postgresql-42.2.22.jar
# End Hung
# COPY database/oracle.xml /tmp/oracle.xml
# COPY database/sqlite.xml /tmp/sqlite.xml
COPY tomcat-users.xml /tmp/tomcat-users.xml
COPY context.xml /tmp/context.xml
COPY olat.properties /tmp/olat.properties
COPY olat.local.properties /tmp/olat.local.properties
# COPY log4j2.xml /tmp/log4j2.xml
COPY entrypoint.sh /entrypoint.sh

RUN apt-get update
RUN apt-get dist-upgrade -y
RUN apt install -y locales locales-all
# Set the locale
RUN sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen && \
    locale-gen
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8     

RUN apt install -y default-jre default-jre-headless unzip curl wget
# RUN apt install -y openjdk-8-jre openjdk-8-jre-headless unzip curl wget
RUN java -version
RUN chmod 0777 /entrypoint.sh

EXPOSE 8080/tcp

ENTRYPOINT ["/bin/bash"]
CMD ["-c", "/entrypoint.sh"]
