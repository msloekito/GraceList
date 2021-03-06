# Be sure to restart your web server when you modify this file.

# Uncomment below to force Rails into production mode when 
# you don't control web/app server and can't set it the proper way
# ENV['RAILS_ENV'] ||= 'production'

# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '1.1.6'

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  # Settings in config/environments/* take precedence those specified here
  
  # Skip frameworks you're not going to use (only works if using vendor/rails)
  # config.frameworks -= [ :action_web_service, :action_mailer ]

  # Add additional load paths for your own custom dirs
  # config.load_paths += %W( #{RAILS_ROOT}/extras )

  # Force all environments to use the same logger level 
  # (by default production uses :info, the others :debug)
  # config.log_level = :debug

  # Use the database for sessions instead of the file system
  # (create the session table with 'rake db:sessions:create')
  # config.action_controller.session_store = :active_record_store

  # Use SQL instead of Active Record's schema dumper when creating the test database.
  # This is necessary if your schema can't be completely dumped by the schema dumper, 
  # like if you have constraints or database-specific column types
  # config.active_record.schema_format = :sql

  # Activate observers that should always be running
  # config.active_record.observers = :cacher, :garbage_collector

  # Make Active Record use UTC-base instead of local time
  # config.active_record.default_timezone = :utc
  
  # See Rails::Configuration for more options
  config.action_controller.session = { :session_key => "_gracelist_session", :secret => "pleaseinsertarandomstringhereforsecuritypurposes" }
end

# Add new inflection rules using the following format 
# (all these examples are active by default):
# Inflector.inflections do |inflect|
#   inflect.plural /^(ox)$/i, '\1en'
#   inflect.singular /^(ox)en/i, '\1'
#   inflect.irregular 'person', 'people'
#   inflect.uncountable %w( fish sheep )
# end

# Include your application configuration below

# Frequency of notifications, N times a week, starting on Sunday
NOTIFY_FREQUENCY = 2

c = YAML::load(File.open("#{RAILS_ROOT}/config/config.yml"))
ActionMailer::Base.raise_delivery_errors = true
ActionMailer::Base.delivery_method = c[RAILS_ENV]['email']['delivery_method']
ActionMailer::Base.smtp_settings = {
   :address => c[RAILS_ENV]['email']['server'],
   :port => c[RAILS_ENV]['email']['port'],
   :domain => c[RAILS_ENV]['email']['domain'],
   :authentication => c[RAILS_ENV]['email']['authentication'],
   :user_name => c[RAILS_ENV]['email']['username'],
   :password => c[RAILS_ENV]['email']['password']
}

# Setup constant variables
RECIPIENT_ALIAS_EMAIL = c[RAILS_ENV]['email']['recipient_alias_email']
FROM_EMAIL = c[RAILS_ENV]['email']['from_email']
RSS = c[RAILS_ENV]['links']['rss']
SUPPORT_LINK = c[RAILS_ENV]['links']['support']

# Required for sending emails
require 'action_controller/integration'