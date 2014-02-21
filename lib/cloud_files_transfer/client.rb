module CloudFilesTransfer
  class Client

    attr_accessor :username, :api_key, :container_name, :snet, :connection

    def initialize(args={})
      @username       = args.fetch(:username) { raise 'Missing username'}
      @api_key        = args.fetch(:api_key) { raise 'Missing api_key'}
      @container_name = args.fetch(:container) { raise 'Missing container'}
      @snet           = args.fetch(:snet, false)
      @connection     = args.fetch(:connection, create_connection)
    end

    def container(name=container_name)
      @container ||= connection.container(name)
    end

    private

    def create_connection
      c = CloudFiles::Connection.new(username: username, api_key: api_key, snet: snet)
      puts "Connection established."
      c
    end

  end
end