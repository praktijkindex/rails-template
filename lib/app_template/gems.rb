# Curated gems
# ------------
# jquery and jquery-ujs are simpler to get as a gem than via bower
# by using --skip-javascript we avoid CoffeScript dependency and
# application.js generation (which will be performed by rails_layout gem)
gem "jquery-rails"
    # idem ditto
    gem "turbolinks"
    # CSS authoring framework: styling extensions built with SASS
    # See http://compass-style.org/
    gem "compass-rails"
    # a superset of JavaScript, compiles to JavaScript
    # adds optional type annotations and more powerful constructs from the future
    gem "typescript-rails"
    # Slim language for HTML templates
    gem "slim-rails"
    # authentication
    gem "devise"

gem_group :development do
  # useful error pages in development server
  gem "better_errors"
  # for REPL in better errors page
  gem "binding_of_caller"
  # - watch Gemfile and run bundler
  gem "guard-bundler", require: false
  # - watch sources and reload rails server
  gem "guard-rails", require: false
  # - watch sources and run tests
  gem "guard-rspec", require: false
  # - watch assets and reload the browser
  gem "guard-livereload", require: false
  # insert livereload support into pages
  gem "rack-livereload"
  # mutes assets pipeline log messages
  gem "quiet_assets"
  # pretty views generators using frameworks (e.g. bootstrap)
  gem "rails_layout"
  # rspec support for spring application preloader
  gem "spring-commands-rspec", require: false
  # better console
  gem "pry-rails"
  # start a pry session whenever something goes wrong
  gem "pry-rescue"
  # static code analyzer, based on the community ruby style guide
  gem "rubocop", require: false
  # bower integration
  gem "bower-rails"
end

gem_group :development, :test do
  # to generate objects for tests
  gem "factory_girl_rails"
  # testing framework
  gem "rspec-rails", require: false
  # better rspec formatter
  gem "fuubar", require: false
end

gem_group :test do
  # browser interaction automation DSL for testing
  gem "capybara"
  # clean testing database before each test
  gem "database_cleaner"
  # PhantomJS driver for capybara
  gem "poltergeist", require: false
end

gem_group :production do
  # application server
  gem "unicorn"
end
