FROM java:openjdk-8-jdk

MAINTAINER Roy Prins <rajprins@gmail.com>

ENV RUNTIME_VERSION "3.8.3"

WORKDIR /opt
RUN wget https://s3.amazonaws.com/new-mule-artifacts/mule-ee-distribution-standalone-${RUNTIME_VERSION}.zip
RUN unzip mule-ee-distribution-standalone-${RUNTIME_VERSION}.zip
RUN rm mule-ee-distribution-standalone-${RUNTIME_VERSION}.zip
RUN ln -s /opt/mule-enterprise-standalone-${RUNTIME_VERSION} /opt/mule

# Define environment variables.
ENV MULE_HOME /opt/mule

# Define mount points.
VOLUME ["/opt/mule/logs", "/opt/mule/apps", "/opt/mule/domains"]

# Define working directory.
WORKDIR /opt/mule

# Mule remote debugger
EXPOSE 5005

# Mule JMX port (must match Mule config file)
EXPOSE 1098

# Mule MMC agent port
EXPOSE 7777

# Mule agent port
EXPOSE 9997

# Default http port
EXPOSE 8081

# Start Mule runtime
CMD /opt/mule/bin/mule
