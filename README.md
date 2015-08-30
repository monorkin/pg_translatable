[![Gem Version](https://badge.fury.io/rb/pg_translatable.svg)](http://badge.fury.io/rb/pg_translatable)
[![Build Status](https://travis-ci.org/Stankec/pg_translatable.svg?branch=master)](https://travis-ci.org/Stankec/pg_translatable)
[![Code Climate](https://codeclimate.com/github/Stankec/pg_translatable/badges/gpa.svg)](https://codeclimate.com/github/Stankec/pg_translatable)
[![Test Coverage](https://codeclimate.com/github/Stankec/pg_translatable/badges/coverage.svg)](https://codeclimate.com/github/Stankec/pg_translatable/coverage)

# About

Store translations in your PG database as HSTORE, JSON or JSONB.

# Instalation

To use this gem in your rails app simply add the following to your `Gemfile`:

```Ruby
gem 'pg_translatable'
```

# Development

After checking out the repo, make sure you have a Postgres database server
 running on your machine then move to the `spec/test_app` directory and run the
 following commands:

```Bash
rake db:create
rake db:migrate
```

# Contributing

1. [Fork it]( https://github.com/Stankec/pg_translatable/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
