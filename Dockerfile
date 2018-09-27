FROM alpine:3.8

# source: https://download.java.net/java/early_access/alpine/28/binaries/openjdk-11+28_linux-x64-musl_bin.tar.gz
# variables
ENV JDK_FILE openjdk-11+28_linux-x64-musl_bin.tar.gz
ENV JAVA_HOME /opt/java
ENV GRADLE_VERSION 4.10
ENV GRADLE_HOME /usr/local/gradle-$GRADLE_VERSION
ENV PATH=$GRADLE_HOME/bin:$JAVA_HOME/bin:$PATH

COPY ${JDK_FILE} /tmp
RUN mkdir /opt; cd /opt; \
    tar zxf /tmp/${JDK_FILE} \
    && ln -s jdk-11 java \
    && rm -f /tmp/${JDK_FILE}

RUN java -version

# Donwload and Install Gradle
RUN apk upgrade --update \
&& apk add curl

RUN \
    cd /usr/local && \
    curl -L https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip -o gradle-${GRADLE_VERSION}-bin.zip && \
    unzip gradle-${GRADLE_VERSION}-bin.zip && \
    rm gradle-${GRADLE_VERSION}-bin.zip


