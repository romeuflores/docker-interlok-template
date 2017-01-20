FROM adaptris/interlok:latest

EXPOSE 8080
EXPOSE 5555

RUN apt-get update && \
    apt-get -y install ant && \
    apt-get clean && \
    cd /var/lib/apt/lists && rm -fr *Release* *Sources* *Packages* && \
    truncate -s 0 /var/log/*log

WORKDIR /opt/interlok
ADD ant /opt/interlok/ant

RUN cd ant && \
    ant -emacs deploy && \
    rm -rf /opt/interlok/ant && \
    rm -rf /root/.ivy2

ADD config /opt/interlok/config

ENTRYPOINT ["/opt/interlok/bin/adapter"]