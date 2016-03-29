shifter
=======

Shifter is a web app that aids in scheduling shifts. It is based on Ruby on Rails.

## Installation

Running ruby in a virtual environment is recommended. Note: This guide uses rbenv; if you are already using RVM or chruby, use the equivalent commands and do not install rbenv.

1. Install `rbenv`: See instructions at https://github.com/rbenv/rbenv (`apt-get install rbenv` on Ubuntu) 
2. Install `ruby-build` with `git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build`
3. `cd` into the script directory (`cd /path/to/shifter`)
4. Install Ruby with `rbenv install 2.3.0` (or a newer version)
5. Ensure that `which ruby` points to `~/.rbenv/shims/ruby`. If not, add `eval "$(rbenv init -)"` to the end of your `~/.bashrc` file.
6. Run `gem install bundler` to install `bundler`. Note: Do not use `sudo`
7. Run `rbenv rehash` to tell  `rbenv` that you now have `bundler`
8. Run `bundle` to install the required gems
9. Install `sqlite3` if not already present on your system (`apt-get install sqlite3` or equivalent)
10. Install `nodejs` if not already present (`sudo apt-get install nodejs` or equivalent)
11. Run `bin/rake db:migrate` (in `/path/to/shifter`) to create the empty database
12. Create a production key to run the server in production mode. Run `RAILS_ENV=production rake secret`, copy the code generated, and paste it into your `~/.bashrc` file as `export SECRET_KEY_BASE=secret_key_output` (where `secret_key_output` is the generated secret key)
13. Log out and log in to get the new environment variables, and navigate back to `/path/to/shifter`
14. Run `bin/rails server -e production` to start the server