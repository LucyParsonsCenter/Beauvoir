#Installing

First, clone the repo. I'd recommend using Debian or Ubuntu to run this app.
Then run:

```
sudo apt-get install libmysqlclient-dev mysql-client ruby-rmagick
mysql-client mysql-common mysql-server
```

You need these as dependencies to get the gems to all build correctly.
Then you can run:

```
bundle install
```

If you don't get any error messages there you're good. Next we need to set
up a database for Borges to populate and edit. Check out
[configuration](CONFIG.md).
