# mesos-playground

This repo provides a vagrant configuration with

- one mesos master
- two mesos slaves
- one docker container with a puppetca (tosmi/puppetca) on the master
- a puppet master (rack based) on each mesos slave in a docker container (tosmi/puppetmaster)
- one haproxy instance on the master that distributes puppet agent request between the running puppetmaster

it's a proof of concept for scaleable puppetmasters via apache mesos and marathon.
