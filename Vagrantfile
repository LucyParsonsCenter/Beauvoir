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

  # install dependencies
  config.vm.provision :shell, inline: <<-SCRIPT
    echo $(whoami)
    apt-get -y update
    apt-get -y upgrade
    apt-get -y install ruby-railties git rbenv bundler build-essential cmake ruby-rmagick
  SCRIPT

  # configure database
  config.vm.provision :shell, inline: <<-SCRIPT
    debconf-set-selections <<< 'mysql-server mysql-server/root_password password abc123'
    debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password abc123'

    apt-get -y install mysql-server-5.5 libmysqlclient-dev libsqlite3-dev
    echo "create user 'borges@localhost' identified by 'password'" | mysql -u root --password=abc123
    echo "create database borgesdev" | mysql -u root --password=abc123
    echo "create database borgestest" | mysql -u root --password=abc123
    echo "create database borgesprod" | mysql -u root --password=abc123
    echo "grant all privileges on borgesdev.* to borges identified by 'password'" | mysql -u root --password='abc123'
    echo "grant all privileges on borgestest.* to borges identified by 'password'" | mysql -u root --password='abc123'
    echo "grant all privileges on borgesprod.* to borges identified by 'password'" | mysql -u root --password='abc123'
  SCRIPT

  # as regular user (vagrant)
  config.vm.provision :shell, privileged: false, inline: <<-SCRIPT
    rbenv install 2.0.0
    rbenv global 2.0.0
    cd /vagrant && bundle install
    cp config/database.test.yml config/database.yml
  SCRIPT

end
