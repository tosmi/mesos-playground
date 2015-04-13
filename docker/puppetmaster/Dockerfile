FROM tosmi/puppet
MAINTAINER Toni Schmidbauer "toni@stderr.at"
ENV REFRESHED_AT 2014-04-13
ADD puppet.conf /etc/puppet/puppet.conf
COPY ssl/ /etc/puppet/ssl/
RUN chown -R puppet:puppet /etc/puppet
ENTRYPOINT ["/usr/bin/puppet", "master","--no-daemonize","--logdest","console"]
EXPOSE 8140
