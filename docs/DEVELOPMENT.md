#Development environment

There's a Vagrantfile included with Borges. If you want to develop with
the vm (it's super nice!) you'll need to have a couple things installed.

If you're running an apt-based Linux distro (like Debian or Ubuntu) do
this:

```
sudo apt-get install virtualbox vagrant
```

then you should be able to do:

```
vagrant up
```

to bring up the vm. You can connect manually by doing `vagrant ssh`, which
is useful to start the Rails server. It should then start in a test mode. Note:
it will take a *long* time to start up the first time you do `vagrant up`- it
needs to download a starter ubuntu image and then do the provisioning
(installing packages and gems to get Rails in a runnable state).

After the first run it should be pretty fast! If you're done developing
for the day you can do 

```
vagrant halt
```

to bring the VM down cleanly, or you can do

```
vagrant destroy
```

to blow everything away (note that you'll need to go through the whole
process again if you do this).

##VM details

The VM runs 32 bit ubuntu 14.04. The Vagrantfile should specify all the
packages that are needed to run Borges.

The shared files are in the VM in `/vagrant` - anything that's in the repo
is shared with the VM. This makes it easy to develop in your local
environment and share changes with the VM (without restarting rails and so
on).

##App details

Borges targets Ruby 2.1.0 - the VM installs this automatically.

In order for the app to work the text search engine has to be running. If
you're in the app directory the command to start it is:

```ruby
rake sunspot:solr:start
```

It should be started automatically when the VM spins up, but strang things
happen sometimes...
