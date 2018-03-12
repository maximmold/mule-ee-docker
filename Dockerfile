FROM         azul/zulu-openjdk
MAINTAINER   Roy Prins <rajprins@gmail.com>

# Define environment variables
ARG         RUNTIME_VERSION=3.9.0
ENV         RUNTIME_VERSION $RUNTIME_VERSION
ENV         MULE_HOME /opt/mule

# Install necessary system tools
RUN         apt-get update && \
            apt-get install -y wget unzip curl vim && \
            rm -rf /var/lib/apt/lists/*

# Download and install Mule runtime
WORKDIR     /opt
#COPY        mule-ee-distribution-standalone-${RUNTIME_VERSION}.zip /opt
#RUN         unzip mule-ee-distribution-standalone-${RUNTIME_VERSION}.zip && \
#            rm mule-ee-distribution-standalone-${RUNTIME_VERSION}.zip && \
#            ln -s /opt/mule-enterprise-standalone-${RUNTIME_VERSION} /opt/mule
RUN         wget https://s3.amazonaws.com/new-mule-artifacts/mule-ee-distribution-standalone-${RUNTIME_VERSION}.zip && \
            unzip mule-ee-distribution-standalone-${RUNTIME_VERSION}.zip && \
            rm mule-ee-distribution-standalone-${RUNTIME_VERSION}.zip && \
            ln -s /opt/mule-enterprise-standalone-${RUNTIME_VERSION} /opt/mule
#ADD        https-1.0.0-SNAPSHOT.zip ${MULE_HOME}/apps/.

#RUN ln -s /opt/mule/logs

# Define mount points
VOLUME      ["/opt/mule-volume"]

RUN rm -rf /opt/mule/logs
RUN rm -rf /opt/mule/apps
RUN rm -rf /opt/mule/domains
RUN rm -rf /opt/mule/conf
RUN ln -s /opt/mule-volume/logs /opt/mule
RUN ln -s /opt/mule-volume/apps /opt/mule
RUN ln -s /opt/mule-volume/domains /opt/mule
RUN ln -s /opt/mule-volume/conf /opt/mule
 
#VOLUME      ["/opt/mule/logs", "/opt/mule/apps", "/opt/mule/domains", "/opt/mule/conf"]

# Copy configuration files
# COPY        ./resources/wrapper.conf ${MULE_HOME}/conf/

# HTTP Service Port
# Expose the necessary port ranges as required by the Mule Apps
EXPOSE      8081-8082

# Mule remote debugger
EXPOSE      5000

# Mule JMX port (must match Mule config file)
EXPOSE      1098

# Mule MMC agent port
EXPOSE      7777

# AMC agent port
EXPOSE      9997

# Start Mule runtime
WORKDIR     /opt/mule
CMD         ["/opt/mule/bin/mule"]
