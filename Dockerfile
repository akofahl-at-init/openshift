#FROM jboss/wildfly:10.1.0.Final
RUN mkdir /tmp/artefacts
RUN curl https://jdbc.postgresql.org/download/postgresql-42.2.5.jar > /tmp/artefacts/postgresql-42.2.5.jar

RUN echo MODE=${MODE} > /tmp/env.properties
RUN cat  /tmp/env.properties
ADD configure.cli /tmp/artefacts/configure.cli
RUN /opt/jboss/wildfly/bin/jboss-cli.sh --file=/tmp/artefacts/configure.cli --properties=/tmp/env.properties

RUN cat /opt/jboss/wildfly/standalone/configuration/standalone.xml

#cleanup

RUN rm -rf /opt/jboss/wildfly/standalone/configuration/standalone_xml_history


ENV JAVA_OPTS="-Delastic.config.host=elasticsearch -Dorg.eclipse.uml2.common.util.CacheAdapter.ThreadLocal \
               -Xms512m -Xmx2048m -Dsun.jnu.encoding=UTF-8 -Dfile.encoding=UTF-8 -Djava.net.preferIPv4Stack=true \
               -Djava.net.preferIPv4Addresses=true "

ADD xrepository3.war /opt/jboss/wildfly/standalone/deployments/xrepository3.war
