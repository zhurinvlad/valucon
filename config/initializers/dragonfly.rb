require 'dragonfly'
require 'dragonfly/s3_data_store'
# Configure
Dragonfly.app.configure do
  plugin :imagemagick

  secret "356172fd11fce005bf9eabd0e85da3497eed228959642ab6bf6898d8c6a73af4"

  url_format "/media/:job/:name"

  # datastore :file,
  #           root_path: Rails.root.join('public/dragonfly', Rails.env),
  #           server_root: Rails.root.join('public')
  datastore :s3,
            bucket_name: 'NAME',
            access_key_id: 'KEY',
            secret_access_key: 'KEY',

            region: 'us-west-2',
            fog_storage_options: {path_style: true}
end

# Logger
Dragonfly.logger = Rails.logger

# Mount as middleware
Rails.application.middleware.use Dragonfly::Middleware

# Add model functionality
if defined?(ActiveRecord::Base)
  ActiveRecord::Base.extend Dragonfly::Model
  ActiveRecord::Base.extend Dragonfly::Model::Validations
end

