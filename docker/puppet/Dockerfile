FROM centos:7
MAINTAINER Toni Schmidbauer "toni@stderr.at"
ENV REFRESHED_AT 2014-04-12
RUN yum -y update
RUN rpm -ivh http://yum.puppetlabs.com/puppetlabs-release-el-7.noarch.rpm && yum -y install puppetserver hostname
RUN chown -R puppet:puppet /etc/puppet
