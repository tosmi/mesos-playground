# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.ssh.forward_agent = true

  config.vm.define "master", primary: true do |master|
    master.vm.box = "puppetlabs/centos-7.0-64-puppet"
    master.vm.hostname = 'master'
    master.vm.box_url = "puppetlabs/centos-7.0-64-puppet"
    master.vm.network "forwarded_port", guest: 5050, host: 5050, auto_correct: true
    master.vm.network "forwarded_port", guest: 8080, host: 8080, auto_correct: true
    master.vm.network "forwarded_port", guest: 8081, host: 8081, auto_correct: true
    master.vm.network "private_network", ip: "192.168.50.2"

    config.vm.provider "virtualbox" do |v|
      v.memory = 2500
    end

    master.vm.provision :puppet do |puppet|
      puppet.manifest_file  = "master.pp"
      puppet.manifests_path = "vagrant/puppet/manifests"
      puppet.module_path = "vagrant/puppet/modules"
      puppet.options = '--verbose --debug'
    end
  end

  config.vm.define "slave1" do |slave1|
    slave1.vm.box = "puppetlabs/centos-7.0-64-puppet"
    slave1.vm.hostname = 'slave1'
    slave1.vm.box_url = "puppetlabs/centos-7.0-64-puppet"
    slave1.vm.network "private_network", ip: "192.168.50.3"

    slave1.vm.provision :puppet do |puppet|
      puppet.manifest_file  = "slave.pp"
      puppet.manifests_path = "vagrant/puppet/manifests"
      puppet.module_path = "vagrant/puppet/modules"
      puppet.options = '--verbose --debug'
    end
  end

  config.vm.define "slave2" do |slave2|
    slave2.vm.box = "puppetlabs/centos-7.0-64-puppet"
    slave2.vm.hostname = 'slave2'
    slave2.vm.box_url = "puppetlabs/centos-7.0-64-puppet"
    slave2.vm.network "private_network", ip: "192.168.50.4"

    slave2.vm.provision :puppet do |puppet|
      puppet.manifest_file  = "slave.pp"
      puppet.manifests_path = "vagrant/puppet/manifests"
      puppet.module_path = "vagrant/puppet/modules"
      puppet.options = '--verbose --debug'
    end
  end
end
