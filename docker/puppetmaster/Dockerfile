FROM centos:7
MAINTAINER Toni Schmidbauer "toni@stderr.at"
ENV REFRESHED_AT 2014-04-08
RUN yum -y update
RUN rpm -ivh http://yum.puppetlabs.com/puppetlabs-release-el-7.noarch.rpm && yum -y install puppet-server
ADD puppet.conf /etc/puppet/puppet.conf
EXPOSE 8140
