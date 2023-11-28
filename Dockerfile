#
# Tomcat 10 is not compatible, see: https://github.com/eurostat/searoute/issues/59
# most other versions break the build as well. Test carefully when upgrading, especially
# test the main endpoint: /seaws?opos=174.8,-36.8&dpos=121.8,31.2&res=5
#
FROM tomcat:9-jre17-temurin-focal

# ensure the system packages are up to date
# to reduce number of potential vulnerabilities
RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# remove the default webapps and logs to keep image small
RUN rm -rf /usr/local/tomcat/webapps/* /usr/local/tomcat/logs/*


COPY searoute-war-3.6.war /usr/local/tomcat/webapps/ROOT.war
# use custom server config which includes a health check endpoint
# required in a containerized environment
COPY server.xml /usr/local/tomcat/conf/server.xml

EXPOSE 5017

CMD ["catalina.sh", "run"]
