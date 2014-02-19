module CloudFilesTransfer
  class Container

    attr_accessor :container, :skip_existing_object

    delegate :object_exists?, :create_object, to: :container

    def initialize(container, args={})
      @container = container
      @skip_existing_object = args.fetch(:skip_existing_object, true)
    end

    def transfer(object)
      return skip_message(object.name) if skip_existing_object and object_exists?(object.name)
      retries = 0
      puts "Saving #{object.name}"
      begin
        copy = create_object(object.name)
        copy.write(object.data)
      rescue Exception
        retries = retries + 1
        unless retries > 5
          puts "#{object.name} failed. Retry"
          retry
        else
          puts "#{object.name} failed."
        end
      end
    end

    private

    def skip_message(object_name)
      puts "#{object_name} skipped."
    end

  end
end