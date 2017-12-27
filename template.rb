


route "root to: 'welcome#index'"


#
# ask
#

@app_name = ask('What is app_name?')

#
# rakefile
#

rakefile('app.rake') do
  <<-TASK
    namespace :app do
      namespace :dev do
        task reset: %i( db:drop db:create db:migrate db:seed app:dev:bank_data app:dev:sample)
        task sample: :environment do
        end
      end
    end
  TASK
end

#
# Gemfile
#

gem 'pg', '~> 0.18'
gem_group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'
end

gem_group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

gem 'json'
gem 'jwt'
gem 'oj'
gem 'oj_mimic_json'
gem 'bcrypt-ruby'
gem 'carrierwave'
gem 'file_validators'
gem 'rmagick'
gem 'fog'
gem 'recaptcha', require: 'recaptcha/rails'
gem 'kaminari'
gem 'bootstrap-kaminari-views'
gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'jquery-turbolinks'
gem 'rails-i18n'
gem 'awesome_print'
gem 'config'
gem 'aws-sdk'
gem 'paranoia'
gem 'annotate'
gem 'enum_help'
gem 'inky-rb', require: 'inky'
gem 'premailer-rails'
gem 'draper'
gem 'activemodel-serializers-xml'
gem 'guard'
gem 'meta-tags'
gem 'ransack'
gem 'pundit'
gem 'cocoon'
gem 'haml-rails'
gem 'font-awesome-sass'
gem 'autoprefixer-rails'
gem 'bootstrap-sass'
gem 'hiredis', require: ['redis', 'redis/connection/hiredis']
gem 'redis'
gem 'redis-namespace'
gem 'redis-objects'
gem 'connection_pool'
gem 'httparty'


gem 'sidekiq'
gem 'audited'
gem 'acts-as-taggable-on'
gem 'factory_bot'
gem 'bootstrap-generators'
gem 'faker'
gem 'faker-japanese'
gem 'breadcrumbs_on_rails'
gem 'i18n-tasks'


gem_group :development, :test do
  gem 'timecop'
  gem 'rspec'
  gem 'rspec-rails'
  gem 'erb2haml'
  gem 'database_cleaner'
  gem 'rspec-request_describer'
  gem 'database_rewinder'
  gem 'json_spec'
  gem 'guard-rspec'
  gem 'rubocop'
  gem 'letter_opener_web'
  gem 'simplecov', require: false
  gem 'webmock'
end

gem_group :development do
  gem 'bullet'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'pry-rails'
  gem 'hirb'
  gem 'hirb-unicode'
end

gem 'devise'
gem 'omniauth'
gem 'omniauth-twitter'
gem 'omniauth-facebook'
gem 'omniauth-google-oauth2', '0.5.0'
gem 'foreman'
add_source "https://rails-assets.org" do
  gem 'rails-assets-bootstrap-fileinput'
  gem 'rails-assets-eonasdan-bootstrap-datetimepicker'
end

#
# run
#
run 'bundle install'
run './bin/rake haml:replace_erbs'
run 'bundle exec annotate'

#
# generators
#

generate 'rspec:install'
generate 'rails_config:install'


#
# remove
#

remove_file 'config/database.yml'

#
# heroku
#


file 'config/database.yml', <<-CODE
# PostgreSQL. Versions 9.1 and up are supported.
 #
 # Install the pg driver:
 #   gem install pg
 # On OS X with Homebrew:
 #   gem install pg -- --with-pg-config=/usr/local/bin/pg_config
 # On OS X with MacPorts:
 #   gem install pg -- --with-pg-config=/opt/local/lib/postgresql84/bin/pg_config
 # On Windows:
 #   gem install pg
 #       Choose the win32 build.
 #       Install PostgreSQL and put its /bin directory on your path.
 #
 # Configure Using Gemfile
 # gem 'pg'
 #
 default: &default
   adapter: postgresql
   encoding: unicode
   # For details on connection pooling, see Rails configuration guide
   # http://guides.rubyonrails.org/configuring.html#database-pooling
   pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>

 development:
   <<: *default
   database: #{@app_name}_development

   # The specified database role being used to connect to postgres.
   # To create additional roles in postgres see `$ createuser --help`.
   # When left blank, postgres will use the default role. This is
   # the same name as the operating system user that initialized the database.
   #username: sharedine

   # The password associated with the postgres role (username).
   #password:

   # Connect on a TCP socket. Omitted by default since the client uses a
   # domain socket that doesn't need configuration. Windows does not have
   # domain sockets, so uncomment these lines.
   #host: localhost

   # The TCP port the server listens on. Defaults to 5432.
   # If your server runs on a different port number, change accordingly.
   #port: 5432

   # Schema search path. The server defaults to $user,public
   #schema_search_path: myapp,sharedapp,public

   # Minimum log levels, in increasing order:
   #   debug5, debug4, debug3, debug2, debug1,
   #   log, notice, warning, error, fatal, and panic
   # Defaults to warning.
   #min_messages: notice

 # Warning: The database defined as "test" will be erased and
 # re-generated from your development database when you run "rake".
 # Do not set this db to the same as development or production.
 test:
   <<: *default
   database: #{@app_name}_test

 # As with config/secrets.yml, you never want to store sensitive information,
 # like your database password, in your source code. If your source code is
 # ever seen by anyone, they now have access to your database.
 #
 # Instead, provide the password as a unix environment variable when you boot
 # the app. Read http://guides.rubyonrails.org/configuring.html#configuring-a-database
 # for a full rundown on how to provide these environment variables in a
 # production deployment.
 #
 # On Heroku and other platform providers, you may have a full connection URL
 # available as an environment variable. For example:
 #
 #   DATABASE_URL="postgres://myuser:mypass@localhost/somedatabase"
 #
 # You can use this database configuration with:
 #
 #   production:
 #     url: <%= ENV['DATABASE_URL'] %>
 #
 production:
   <<: *default
   database: #{@app_name}_production
   username: @app_name
   password: <%= ENV['"#{@app_name.upcase}"'] %>
CODE

run 'echo "# #{@app_name}" >> README.md'
git :init
git add: "."
git commit: %Q{ -m 'Initial commit' }
git remote: "add origin #{app_name}"
git push: '-u origin master'


run "heroku create #{@app_name}"
git push: 'heroku master'
run 'heroku run rake db:migrate'
