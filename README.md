# Form Generator

[![main-check](https://github.com/RamiGaggi/rails-project-lvl1/actions/workflows/main-check.yml/badge.svg)](https://github.com/RamiGaggi/rails-project-lvl1/actions/workflows/main-check.yml) [![Maintainability](https://api.codeclimate.com/v1/badges/9e621a0a9939c3154a02/maintainability)](https://codeclimate.com/github/RamiGaggi/rails-project-lvl1/maintainability)

Form Generator is a library to create forms for site templates.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'html_form_generator'
```

And then execute:

$ make install

## Usage

```ruby
User = Struct.new(:id, :name, :job)
user = User.new

html = HtmlFormGenerator.form_for user, url: '/users' do |f|
  f.input :name
  f.input :job, as: :text
  f.submit
end

puts html

# <form action="/users" method="post">
#   <label for="name">Name</label>
#   <input name="name" value="" type="text">
#   <label for="job">Job</label>
#   <textarea cols="20" rows="40" name="job"></textarea>
#   <input type="submit" value="Create">
# </form>
```

## Development

1) To install dependencies `bin/setup`.
2) To run the tests `make test` . You can also run `bin/console` for .
3) An interactive prompt that will allow you to experiment `make console`
4) Install this gem onto your local machine - run `bundle exec rake install`.
