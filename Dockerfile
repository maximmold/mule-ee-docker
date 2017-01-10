FROM         azul/zulu-openjdk
MAINTAINER   Roy Prins <rajprins@gmail.com>

# Define environment variables
ENV         RUNTIME_VERSION "3.8.3"
ENV         MULE_HOME /opt/mule

# Install necessary system tools
RUN         apt-get update && \
            apt-get install -y wget unzip && \
            rm -rf /var/lib/apt/lists/*

# Download and install Mule runtime
WORKDIR     /opt
RUN         wget https://s3.amazonaws.com/new-mule-artifacts/mule-ee-distribution-standalone-${RUNTIME_VERSION}.zip && \
            unzip mule-ee-distribution-standalone-${RUNTIME_VERSION}.zip && \
            rm mule-ee-distribution-standalone-${RUNTIME_VERSION}.zip && \
            ln -s /opt/mule-enterprise-standalone-${RUNTIME_VERSION} /opt/mule

# Define mount points
VOLUME      ["/opt/mule/logs", "/opt/mule/apps", "/opt/mule/domains"]

# Apply patch for issue se-4497
COPY        ./resources/se-4497-3.8.1.jar ${MULE_HOME}/lib/user

# Remote debugger, JMX port, MMC agent, agent, default HTTP port
EXPOSE      5005 1098 7777 9997 8081

# Start Mule runtime
CMD         ["/opt/mule/bin/mule"]
