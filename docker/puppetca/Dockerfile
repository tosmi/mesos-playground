FROM tosmi/puppet
MAINTAINER Toni Schmidbauer "toni@stderr.at"
ENV REFRESHED_AT 2014-04-12
RUN yum -y update
ADD puppet.conf /etc/puppet/puppet.conf
ENTRYPOINT ["/usr/bin/puppet", "master","--no-daemonize","--logdest","console"]
EXPOSE 8140
