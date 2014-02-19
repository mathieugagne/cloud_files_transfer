require 'cloudfiles'
require "cloud_files_transfer/version"
require 'cloud_files_transfer/client'
require 'cloud_files_transfer/container'

module CloudFilesTransfer
  class Railtie < Rails::Railtie

    rake_tasks do
      Dir[File.join(File.dirname(__FILE__),'tasks/*.rake')].each { |f| load f }
    end

  end
end