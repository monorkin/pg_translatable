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

# Usage

To translate your model's fields you must call the `translate` method:

```Ruby
# app/models/post.rb

class Post < ActiveRecord::Base
  translate :title, :content

  ...

end
```

These fields will be translated to all locales that you have defined in
`config.i18n.available_locales`.

E.g. the following configuration would store translations for english, german,
french and spanish:

```Ruby
# config/application.rb

module TestApp
  class Application < Rails::Application
    config.i18n.default_locale = :en
    config.i18n.available_locales = [:en, :de, :fr, :es]
  end
end
```

## Getters and setters

When you call the field's name in singular it will return the value for the
current locale, that is the locale defined in `I18n.locale`. So for the above
example, if my current locale was set to `:fr` calling `title` would return the
title in french.

When you call the field's name in plural it will return a hash containing all
translations. For the above example, calling `titles` would return a hash
containing all translations.

Additionally a per locale getter and setter will be defined for each field.
For the above example the following getters and setters would be generated:
`title_en`, `title_de`, `title_fr`, `title_es`,
`content_en`, `content_de`, `content_fr`, `content_es`

__NOTE:__ If it happens that the singular and plural of a given field are the
same then the plural will get suffixed with `_translations`.

E.g. If there was a field called `news` it's getters and setters would be
`news` for the current translation and `news_translations` for the
translations hash.

## Formatters

If you want to format the output of a getter method then you can just redefine
the formatter method for any field.

E.g. if you wanted your content's translations to be returned in reverse:

```Ruby
# app/models/post.rb

class Post < ActiveRecord::Base
  translate :title, :content, :price

  private

  def content_formatter(value)
    value.to_s.reverse
  end
end
```

__NOTE:__ Only getters pass data through formatters, setters save data given to
them as is.

## Strong params

To better integrate translations with strong parameters a convenience method
will be defined for each field, it will just be suffixed with `_fields`.

For the above example you could do the following:

```Ruby
# app/controllers/posts_controller.rb

class PostsController < ApplicationController

  ...

  private

  def post_params
    params.require(:post).permit(
      *Post.title_fields,
      *Post.content_fields
    )
  end

  ...

end
```

## Validation

There is no practical solution for validating this kind of data.
My suggestion is to write custom validator classes.

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
