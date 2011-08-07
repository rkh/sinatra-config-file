Sinatra::ConfigFile
===================

Adds YAML config file support to [Sinatra](http://sinatrarb.com).

Config files are expected to represent hashes. When parsing such a config file it will use set to store that value,
ignoring those directly defined in the app (not those defined by the class it inherits from, i.e. Sinatra::Base).


Installation
------------

    gem install sinatra-config-file

Example
-------

    require "sinatra"
    require "sinatra/config_file"

    configure do |c|
      set :foo, "bar"
      config_file "settings.yml",                 # general settings
                  "#{c.environment}.settings.yml" # environment specific settings
      foo # => "bar" (no matter what you put in your config files)
    end

Now you could write in your settings.yml:

    ---
    server: [thin, webrick] # use only thin or webrick for #run!
    public: /var/www        # load public files from /var/www
    port:   8080            # run on port 8080
    foo: baz
    database:
      adapter: sqlite

In you development.settings.yml:

    database:
      db_file: development.db

Note
----
Each call to config_file is independent, such that if you do the following:

  configure do |c|
    config_file "settings.yml"
    config_file "#{c.environment}.settings.yml"
  end

any keys in both files will only be pulled from "settings.yml", including
hashes.

However, when you specify both files in the same call, the settings in later
files override the settings in earlier files.
