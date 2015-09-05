# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "ubuntu/trusty32"
  config.vm.network "forwarded_port", guest: 80, host: 8080

 
  config.vm.provider "virtualbox" do |vb|
    vb.gui = false
    vb.customize ["modifyvm", :id, "--memory", "1024"]
    vb.cpus = 2
  end

  config.vm.provision :shell, inline: <<-SCRIPT
    apt-get -y update
    apt-get -y upgrade
    apt-get -y install ruby-railties git ruby bundler mysql-server &&
    cd /vagrant && bundle install
  SCRIPT

end
