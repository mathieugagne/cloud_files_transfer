module CloudFilesTransfer
  class Transfer

    attr_accessor :origin, :destination, :path

    def initialize(origin, destination, path, args={})
      @origin = origin
      @destination = destination
      @path = path
    end

    def self.copy!(origin, destination, path, args={})
      return puts("#{path} skipped.".colorize(:light_blue)) if (destination.object_exists?(path) rescue false)
      new(origin, destination, path, args).copy
    end

    def copy
      retries = 0
      begin
        origin_object = origin.object(path)
        desintation_object = destination.create_object(path)
        desintation_object.write(origin_object.data)
        success("#{path} saved")
      rescue Exception
        retries = retries + 1
        unless retries > 2
          warn("#{path} failed. Retry")
          retry
        else
          fail("#{path} failed.")
        end
      end
    end

    private

    def info message
      colored_print(message, :light_blue)
    end

    def warn message
      colored_print(message, :yellow)
    end

    def success message
      colored_print(message, :green)
    end

    def fail message
      colored_print(message, :red)
    end

    def colored_print message, color
      puts(message.colorize(color))
    end

  end
end