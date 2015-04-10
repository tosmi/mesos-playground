FROM tosmi/puppet
MAINTAINER Toni Schmidbauer "toni@stderr.at"
ENV REFRESHED_AT 2014-04-10
RUN yum -y update
ADD puppet.conf /etc/puppet/puppet.conf
ENTRYPOINT ["/usr/bin/puppetserver", "foreground"]
EXPOSE 8140
