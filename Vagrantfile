# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.ssh.forward_agent = true

  config.vm.define "railsdev" do |dev|
    dev.vm.box = "centos-65-x64-virtualbox-puppet"
    dev.vm.hostname = 'master'
    dev.vm.box_url = "http://puppet-vagrant-boxes.puppetlabs.com/centos-65-x64-virtualbox-puppet.box"
    dev.vm.network "forwarded_port", guest: 80,   host: 8086
    dev.vm.network "forwarded_port", guest: 443,  host: 8443
    dev.vm.network "forwarded_port", guest: 3000, host: 3000

    dev.vm.provision :puppet do |puppet|
      puppet.manifest_file  = "init.pp"
      puppet.manifests_path = "vagrant/puppet/manifests"
      puppet.module_path = "vagrant/puppet/modules"
      puppet.options = '--verbose --debug'
    end
  end
end
