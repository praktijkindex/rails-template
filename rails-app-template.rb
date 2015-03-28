# Usage
# -----
#
# rails new ApplicationName -m PATH_TO/rails-app-template.rb --rc=PATH_TO/railsrc

$LOAD_PATH << File.expand_path("../lib", __FILE__)
require "app_template"

AppTemplate.new do

  commit "Initial commit"

  commit "Curated gems" do
    source "gems"
  end

  commit "Copy template files" do
    delete_files %w[
      README.rdoc
      app/views/layouts/application.html.erb
      app/helpers/application_helper.rb
      config/locales/en.yml
    ]
    copy_files File.expand_path("../files", __FILE__)
    run "ln -s config/Guardfile ."
    run "mv Gemfile config/"
    run "ln -s config/Gemfile ."
  end

  commit "Bundle gems" do
    run "bundler install"
  end

  commit "Bower-managed front end components" do
    rake "bower:install"
    append_to ".gitignore", "/vendor/assets/bower_components"
  end

  commit "Nederlands als eerste taal" do
    application "config.i18n.default_locale = :nl"
  end

  commit "Rspec setup" do
    generate "rspec:install"
  end

  commit "Devise setup" do
    generate "devise:install"
    generate "devise User"
    rake "db:create"
    rake "db:migrate"
    route "devise_for :users"
  end

  commit "Root route" do
    route %Q[root to: "application#index"]
  end

  commit "Binstubs" do
    run "spring binstub --all"
    run "bundle binstubs guard"
  end

end
