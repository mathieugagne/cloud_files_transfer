module CloudFilesTransfer
  class Client

    attr_accessor :username, :api_key, :container_name, :connection

    def initialize(args={})
      @username       = args.fetch(:username, credentials[:rackspace_username])
      @api_key        = args.fetch(:api_key, credentials[:rackspace_api_key])
      @container_name = args.fetch(:container, CarrierWave::Uploader::Base.fog_directory)
      @connection     = args.fetch(:connection, create_connection)
    end

    def container(name=container_name)
      @container ||= connection.container(name)
    end

    private

    def create_connection
      c = CloudFiles::Connection.new(username: username, api_key: api_key)
      puts "Connection established."
      c
    end

    def credentials
      @credentials ||= CarrierWave::Uploader::Base.fog_credentials
    end

  end
end