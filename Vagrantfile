# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "ubuntu/trusty32"
  config.vm.network "forwarded_port", guest: 3000, host: 3000

 
  config.vm.provider "virtualbox" do |vb|
    vb.gui = false
    vb.customize ["modifyvm", :id, "--memory", "1024"]
    vb.cpus = 2
  end

  # install dependencies
  config.vm.provision :shell, privileged: true, inline: <<-SCRIPT
    apt-get -y update
    apt-get -y upgrade
    apt-get -y install ruby-railties git rbenv bundler build-essential cmake ruby-rmagick ruby-build jvm-7-avian-jre rmagic imagemagick libmagickwand-dev libjetty-extra-java libtomcat7-java solr-jetty silversearcher-ag nodejs-legacy npm
  SCRIPT

  # configure database
  config.vm.provision :shell, privileged: true, inline: <<-SCRIPT
    debconf-set-selections <<< 'mysql-server mysql-server/root_password password abc123'
    debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password abc123'

    apt-get -y install mysql-server-5.5 libmysqlclient-dev libsqlite3-dev

    echo "configuring database..."
    echo "create user 'borges@localhost' identified by 'password'" | mysql -u root --password=abc123
    echo "create database borgesdev" | mysql -u root --password=abc123
    echo "create database borgestest" | mysql -u root --password=abc123
    echo "create database borgesprod" | mysql -u root --password=abc123
    echo "grant all privileges on borgesdev.* to borges identified by 'password'" | mysql -u root --password='abc123'
    echo "grant all privileges on borgestest.* to borges identified by 'password'" | mysql -u root --password='abc123'
    echo "grant all privileges on borgesprod.* to borges identified by 'password'" | mysql -u root --password='abc123'
    echo "done."
  SCRIPT

  # as regular user (vagrant)
  config.vm.provision :shell, privileged: false, inline: <<-SCRIPT
    echo "\n\nconfiguring rails environment..."
    rbenv install 2.0.0
    rbenv global 2.0.0
    rm -r solr
    rm config/sunspot.yml
    cd /vagrant && bundle install
    cp config/database.test.yml config/database.yml
    cp config/application.test.yml config/application.yml

    git clone https://github.com/aliceriot/borges-utils ~/borges-utils

    gpg --keyserver pgp.mit.edu --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
    \curl -sSL https://get.rvm.io | bash -s stable
    source ~/.rvm/scripts/rvm
    rvm install 2.1.0
    rvm use 2.1.0

    source ~/.profile
    if [ -z "$DEVISE_TOKEN" ]; then
        echo 'export DEVISE_TOKEN="a4ed267775e7b70b4b1fbc86520495ce0df1e5e7c3e3091374e47eb9c9051d3874f2186d7b99d7b6f6c67fba1b1cb990a56a9919418c36c70ba4e745ada3d0d7"' >> ~/.profile
    fi

    if [ -z "$SECRET_TOKEN" ]; then
        echo 'export SECRET_TOKEN="f390931c0d2899dc13ca0ca6465903eee6b4e8c1"' >> ~/.profile
    fi

    export DEVISE_TOKEN="a4ed267775e7b70b4b1fbc86520495ce0df1e5e7c3e3091374e47eb9c9051d3874f2186d7b99d7b6f6c67fba1b1cb990a56a9919418c36c70ba4e745ada3d0d7"
    export SECRET_TOKEN="f390931c0d2899dc13ca0ca6465903eee6b4e8c1"

    bundle exec rake db:schema:load
    rails generate sunspot_rails:install

    echo "done."
  SCRIPT

end
