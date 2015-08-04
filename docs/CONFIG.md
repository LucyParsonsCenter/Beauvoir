##Configuration and Setup

OK, here's what you need to do in order to get Borges running. It's a lot, but
stick with it and it will work! I promise! First up we need to set up the
databases for Borges. Do this stuff to create a new database user for Borges
and a development and production database:

```
mysql --user=root --password
```

(this will ask for your root password). Once you're in the db make a new user:

```
CREATE USER 'borges'@'localhost' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON *.* TO 'borges'@'localhost' WITH GRANT OPTION;
quit
```

that will create a user (borges). Now we can edit the database file! In Borges
there's a file in `config/database.example.yml`. Copy that to
`config/database.yml` and edit it!

The fields to change are the `password`, and `user` fields in
the `test`, `production`, and `development` sections. Make them match what
you did when you created the user for the application above.

You may also have to change the socket location in `config/database.yml`.
On Debian, by default, it's in `/var/run/mysqld/mysqld.sock`. If mysqld is
already running you can check to see that the socket file exists in that
directory.

Then start mysql by doing:

```
sudo /etc/init.d/mysql start
```

Then create the databases and get the schema in by doing:

```
bundle exec rake db:setup
```

That should be it?

##Application configuration

Copy the `config/application.example.yml` to `config/application.yml` and edit
the fields in there. Plz don't commit this file.

If you get a complaint from Devise just copy the secret key hash it spits out
into the `config.secret_key` variable in `config/initializers/devise.rb`.

You'll probably also need to add a secret to
`config/initializers/secret_token.rb` This should be a hexadecimal hash string.
You can generate a SHA1 digest of some text (make it a bit random, although if
it's just for development on your machine it probably doesn't matter) by doing:

```
echo -n "lol cryptography" | openssl dgst -sha1 -hmac "key"
```

this will return the hex representation of the SHA1 hash of 'my text...'.
Sweet! This is the secret key which is used to sign cookies that are
placed in the browser - so don't change it, or else the app won't be able to
recognize its cookies anymore (sad).

Note: you can also leave Borges untouched (by default it looks for those
last two variables as environment variables) and export the secrets in your
`.bashrc` or elsewhere. That may be safer, although again, for local
development or deployment it's probably not a worry.

##Migrating from Infoshopkeeper

If you've gotten to this point you're now ready to migrate the data from
Infoshopkeeper to Borges. It's really not too bad! Here we go.

First we want to edit the `lib/tasks/import_from_infoshopkeeper.rake` and
change the `isk_db`, `isk_db_user`, and `isk_db_password` fields to match
what Infoshopkeeper was using.

Then you should just be able to do:

```
bundle exec rake infoshopkeeper:import
```

##Running the app

If you'd like to run the app on your own machine for development just do

```
rails server
```

in the main directory. If you took care of all the configuration details
you should be good!














