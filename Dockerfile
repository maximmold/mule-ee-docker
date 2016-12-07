FROM java:openjdk-8-jdk

MAINTAINER rajprins@gmail.com

RUN cd /opt && wget http://s3.amazonaws.com/new-mule-artifacts/mule-ee-distribution-standalone-3.8.3.tar.gz
RUN cd /opt && tar xvzf mule-ee-distribution-standalone-3.8.3.tar.gz && rm mule-ee-distribution-standalone-3.8.3.tar.gz && ln -s /opt/mule-enterprise-standalone-3.8.3 /opt/mule

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
CMD [ "/opt/mule/bin/mule" ]
