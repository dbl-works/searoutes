#
# Tomcat 10 is not compatible, see: https://github.com/eurostat/searoute/issues/59
# most other versions break the build as well. Test carefully when upgrading, especially
# test the main endpoint: /seaws?opos=174.8,-36.8&dpos=121.8,31.2&res=5
#
FROM tomcat:9.0.68-jre17-temurin-focal

RUN mkdir -p /usr/local/tomcat/webapps/
RUN rm -rf /usr/local/tomcat/webapps/*
ADD searoute-war-3.6.war /usr/local/tomcat/webapps/ROOT.war

# use custom server config
# e.g. we expose side-car containers on ports 5xxx on ECS
RUN rm -rf /usr/local/tomcat/conf/server.xml
ADD server.xml /usr/local/tomcat/conf/server.xml

EXPOSE 5017

CMD ["catalina.sh", "run"]
