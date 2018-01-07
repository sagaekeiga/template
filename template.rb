


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
        task reset: %i( db:drop db:create db:migrate db:seed app:dev:sample)
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
gem 'google-analytics-rails'
gem 'dotenv-rails'
gem 'honoka-rails'
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
  gem 'rubocop', require: false
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

gsub_file 'Gemfile', "gem 'sqlite3'", "# gem 'sqlite3'"
run 'bundle install'
run './bin/rake haml:replace_erbs'


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
   username: #{@app_name}
   password: <%= ENV['"#{@app_name.upcase}"'] %>
CODE

#
# env
#

file '.env', <<-CODE
# Omniauth
FACEBOOK_APP_ID=""
FACEBOOK_APP_SECRET=""

# Google reCAPTCHA
RECAPTCHA_SITE_KEY=""
RECAPTCHA_SECRET_KEY=""

# Redis
# for Docker
# REDIS_URL=redis://cache:6379/0
REDIS_URL=redis://localhost:6379/0

RAILS_LOG_TO_STDOUT=true

# GOOGLE ANALYTICS
GOOGLE_TRACKING_ID=UA-111735982-1
CODE

file 'dotenv.sample', <<-CODE
# Omniauth
FACEBOOK_APP_ID=""
FACEBOOK_APP_SECRET=""

# Google
GOOGLE_CLIENT_ID=""
GOOGLE_CLIENT_SECRET=""
GOOGLE_REDIRECT_URI=""

# Redis
# for Docker
# REDIS_URL=redis://cache:6379/0
REDIS_URL=redis://localhost:6379/0

RAILS_LOG_TO_STDOUT=true

# GMO Payment Gateway
GMO_PG_SITE_ID=""
GMO_PG_SITE_PASS=""
GMO_PG_SHOP_ID=""
GMO_PG_SHOP_PASS=""
GMO_PG_API_URL=""

# Pusher
PUSHER_ID=""
PUSHER_KEY=""
PUSHER_SECRET=""
PUSHER_CLUSTER=""

# domain constraint
WEB_DOMAIN=""
CODE

#
# SCSS
#
remove_file 'app/assets/stylesheets/application.css'

file 'app/assets/stylesheets/application.scss', <<-CODE
/*
 * This is a manifest file that'll be compiled into application.css, which will include all the files
 * listed below.
 *
 * Any CSS and SCSS file within this directory, lib/assets/stylesheets, or any plugin's
 * vendor/assets/stylesheets directory can be referenced here using a relative path.
 *
 * You're free to add application-wide styles to this file and they'll appear at the bottom of the
 * compiled file so the styles you add here take precedence over styles defined in any other CSS/SCSS
 * files in this directory. Styles in this file should be added after the last require_* statement.
 * It is generally better to create a new file per style scope.
 *
 *= require_tree .
 *= require_self
 */

@import 'bootstrap-sprockets';
@import 'bootstrap';
@import 'bootstrap-fileinput';
@import 'honoka';

.m-t-0 { margin-top: 0; }
.m-t-1 { margin-top: $padding-base-vertical; }
.m-t-2 { margin-top: $padding-base-vertical * 2; }
.m-t-4 { margin-top: $padding-base-vertical * 4; }

.m-b-0 { margin-bottom: 0; }
.m-b-1 { margin-bottom: $padding-base-vertical; }
.m-b-2 { margin-bottom: $padding-base-vertical * 2; }

.p-l-1 { padding-left: $padding-base-horizontal; }
.p-r-1 { padding-right: $padding-base-horizontal; }
.p-b-1 { padding-bottom: $padding-base-horizontal; }

.m-l-1 { margin-left: $padding-base-horizontal; }
.m-r-1 { margin-right: $padding-base-horizontal; }
CODE

#
# SCSS
#
remove_file 'app/assets/javascripts/application.js'

file 'app/assets/javascripts/application.coffee', <<-CODE
# This is a manifest file that'll be compiled into application.js, which will include all the files
# listed below.
#
# Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
# vendor/assets/javascripts directory can be referenced here using a relative path.
#
# It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
# compiled file. JavaScript code in this file should be added after the last require_* statement.
#
# Read Sprockets README (https:#github.com/rails/sprockets#sprockets-directives) for details
# about supported directives.
#
#= require rails-ujs
#= require jquery
#= require jquery.turbolinks
#= require turbolinks
#= require bootstrap
#= require bootstrap-sprockets
#= require bootstrap-fileinput
#= require bootstrap-fileinput/locales/ja
#= require moment
#= require moment/locale/ja
#= require cocoon
#= require turbolinks
#= require_tree .

# こちらはページ遷移する度に呼ばれる（初回ページ読み込み時も含む）
$(document).on 'turbolinks:load', ->

  #
  # File Input
  #
  $('input[type="file"]').fileinput
    showUpload: false
    showPreview: true
    allowedPreviewMimeTypes: false
    previewFileType: 'image'
    language: 'ja'
CODE

#
# application.html.haml
#

remove_file 'app/views/layouts/application.html.haml'
key = 'key'
file 'app/views/layouts/application.html.haml', <<-CODE
!!!
%html
  %head
    %meta{ content: 'text/html; charset=UTF-8', 'http-equiv': 'Content-Type' }/
    %meta{ name: 'viewport', content: 'width=device-width, initial-scale=1.0' }
    %title #{@app_name}
    = csrf_meta_tags
    = stylesheet_link_tag    'application', media: 'all', 'data-turbolinks-track': 'reload'
    = javascript_include_tag 'application', 'data-turbolinks-track': 'reload'
  %body
    %header
      %nav
        - if user_signed_in?
          %strong
            = link_to 'プロフィール変更', edit_user_registration_path
            = link_to 'ログアウト', destroy_user_session_path, method: :delete
        - else
          = link_to 'サインアップ', new_user_registration_path
          = link_to 'ログイン', new_user_session_path

    - !content_for?(:flash) && flash && flash.each do |key, message|
      .alert{ class: "alert-#{key}", role: 'alert' }
        %strong= message
    = yield
CODE

#
# Devise
#
run 'rails g devise:install'
remove_file 'config/environments/development.rb'
file 'config/environments/development.rb', <<-CODE
Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # mailer
  config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports.
  config.consider_all_requests_local = true

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false

  config.action_mailer.perform_caching = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

  # Suppress logger output for asset requests.
  config.assets.quiet = true

  # Raises error for missing translations
  # config.action_view.raise_on_missing_translations = true

  # Use an evented file watcher to asynchronously detect changes in source code,
  # routes, locales, etc. This feature depends on the listen gem.
  config.file_watcher = ActiveSupport::EventedFileUpdateChecker
end
CODE
run 'rails g devise:views'
run 'rails g devise User'

#
# generators
#

generate 'rails_config:install'
run 'bundle exec rails g config:install'
generate 'rspec:install'
run 'bundle exec annotate'
run 'rails app:dev:reset'
run "echo # #{@app_name} >> 'README.md'"
file '.gitignore', <<-CODE
# See https://help.github.com/articles/ignoring-files for more about ignoring files.
#
# If you find yourself ignoring temporary files generated by your text editor
# or operating system, you probably want to add a global ignore instead:
#   git config --global core.excludesfile '~/.gitignore_global'

# Ignore bundler config.
/.bundle

# Ignore the default SQLite database.
/db/*.sqlite3
/db/*.sqlite3-journal

# Ignore all logfiles and tempfiles.
/log/*
/tmp/*
!/log/.keep
!/tmp/.keep

/public/uploads

/node_modules
/yarn-error.log

.byebug_history

config/settings.local.yml
config/settings/*.local.yml
config/environments/*.local.yml

CODE
git :init
git add: "."
git commit: %Q{ -m 'Initial commit' }
git remote: "add origin https://github.com/sagaekeiga/#{@app_name}.git"
git push: '-u origin master'


run "heroku create #{@app_name}"
git push: 'heroku master'
run 'heroku run rake db:migrate'
