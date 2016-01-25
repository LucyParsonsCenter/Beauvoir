# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "ubuntu/trusty32"
  config.vm.network "forwarded_port", guest: 3000, host: 3000
  config.vm.network :private_network, ip: '192.168.50.50'
  config.vm.synced_folder '.', '/vagrant', nfs: true, nfs_export: true

  config.vm.provider "virtualbox" do |vb|
    vb.gui = false
    vb.customize ["modifyvm", :id, "--memory", "1024"]
    vb.cpus = 2
  end

  # install dependencies, configure db
  config.vm.provision :shell, privileged: true, inline: <<-SCRIPT
    sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ precise-pgdg main" >> /etc/apt/sources.list.d/pgdg.list'
    wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -

    apt-get -y update
    apt-get -y upgrade

    apt-get -y install git build-essential nodejs-legacy npm cmake ruby-build silversearcher-ag postgresql-9.3 postgresql-server-dev-9.3 postgresql-contrib-9.3 libyaml-dev sqlite3 autoconf libgdbm-dev libncurses5-dev automake libtool bison pkg-config libffi-dev libpq-dev
    sudo -u postgres createuser --superuser vagrant
  SCRIPT

  # as regular user (vagrant)
  # set up ruby, install gems, set up db
  config.vm.provision :shell, privileged: false, inline: <<-SCRIPT
    echo "\n\nconfiguring ruby/rails environment..."
    git clone https://github.com/aliceriot/beauvoir-utils ~/beauvoir-utils
    gpg --keyserver pgp.mit.edu --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
    curl -sSL https://get.rvm.io | bash -s stable
    source ~/.rvm/scripts/rvm
    rvm install ruby-2.2.3
    rvm use ruby-2.2.3
    rvm rvmrc warning ignore allGemfiles
    cd /vagrant
    gem install bundler
    bundle install --full-index -j4
    source ~/.profile

    if [ -z "$DEVISE_TOKEN" ]; then
        echo 'export DEVISE_TOKEN="a4ed267775e7b70b4b1fbc86520495ce0df1e5e7c3e3091374e47eb9c9051d3874f2186d7b99d7b6f6c67fba1b1cb990a56a9919418c36c70ba4e745ada3d0d7"' >> ~/.profile
    fi

    if [ -z "$SECRET_TOKEN" ]; then
        echo 'export SECRET_TOKEN="f390931c0d2899dc13ca0ca6465903eee6b4e8c1"' >> ~/.profile
    fi
    export DEVISE_TOKEN="a4ed267775e7b70b4b1fbc86520495ce0df1e5e7c3e3091374e47eb9c9051d3874f2186d7b99d7b6f6c67fba1b1cb990a56a9919418c36c70ba4e745ada3d0d7"
    export SECRET_TOKEN="f390931c0d2899dc13ca0ca6465903eee6b4e8c1"

    bundle exec rake db:setup
    bundle exec rake db:create
    bundle exec rake db:migrate
    bundle exec rake db:migrate RAILS_ENV="test"
    echo "cd /vagrant" >> ~/.profile
    echo "done."

    echo "alias dbmigrate='bundle exec rails db:migrate && bundle exec rails db:migrate RAILS_ENV="test"'" >> ~/.bashrc
    echo "alias runspec='bundle exec bin/rspec'" >> ~/.bashrc
  SCRIPT
end
