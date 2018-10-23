FROM  rxvc/jdk:8-jdk-alpine

ARG SCALA_VERSION
ARG SBT_VERSION

ENV SCALA_VERSION ${SCALA_VERSION:-2.12.7}
ENV SBT_VERSION ${SBT_VERSION:-1.2.6}

RUN echo "$SCALA_VERSION $SBT_VERSION" && \
	mkdir -p /usr/lib/jvm/java-1.8-openjdk/jre && \
	touch /usr/lib/jvm/java-1.8-openjdk/jre/release && \
	apk add --no-cache bash && \
	apk add --no-cache curl && \
	wget http://downloads.typesafe.com/scala/$SCALA_VERSION/scala-$SCALA_VERSION.tgz && \
	tar -xvzf scala-$SCALA_VERSION.tgz && \
	mv scala-$SCALA_VERSION /usr/local/ && \
	ln -s /usr/local/scala-$SCALA_VERSION/bin/* /usr/local/bin/ && \ 
	scala -version && \
	scalac -version

RUN wget https://github.com/sbt/sbt/releases/download/v$SBT_VERSION/sbt-$SBT_VERSION.tgz && \
	tar -xvzf sbt-$SBT_VERSION.tgz && \
	mv sbt /usr/local/ && \
	ln -s /usr/local/sbt/bin/* /usr/local/bin/ 

WORKDIR /app
