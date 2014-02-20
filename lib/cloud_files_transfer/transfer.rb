module CloudFilesTransfer
  class Transfer

    attr_accessor :origin, :destination, :path

    def initialize(origin, destination, path, args={})
      @origin = origin
      @destination = destination
      @path = path
    end

    def self.copy!(origin, destination, path, args={})
      return if destination.object_exists?(path)
      new(origin, destination, path, args).copy
    end

    def copy
      retries = 0
      puts "Saving #{path}"
      begin
        origin_object = origin.object(path)
        desintation_object = destination.create_object(path)
        desintation_object.write(origin_object.data)
      rescue Exception
        retries = retries + 1
        unless retries > 5
          puts "#{path} failed. Retry"
          retry
        else
          puts "#{path} failed."
        end
      end
    end

  end
end