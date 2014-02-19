require 'cloudfiles'
require 'sidekiq'
require "cloud_files_transfer/version"
require 'cloud_files_transfer/client'
require 'cloud_files_transfer/container'
require 'cloud_files_transfer/workers/asset_transfer_worker'

module CloudFilesTransfer
  class Railtie < Rails::Railtie

    rake_tasks do
      Dir[File.join(File.dirname(__FILE__),'tasks/*.rake')].each { |f| load f }
    end

  end
end