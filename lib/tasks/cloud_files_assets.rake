namespace :cloud_files_assets do

  desc "Copy assets from one container to another container"
  task transfer: :environment do

    username      = ask("Origin username:")
    api_key       = ask("Origin API key:")
    fog_directory = ask("Origin container name:")
    @client_from  = CloudFilesTransfer::Client.new(
      username: username,
      api_key: api_key,
      fog_directory: fog_directory
    )

    username      = ask("Destination username:")
    api_key       = ask("Destination API key:")
    fog_directory = ask("Destination container name:")
    @client_to    = CloudFilesTransfer::Client.new(
      username: username,
      api_key: api_key,
      fog_directory: fog_directory
    )

    @container_from = @client_from.container
    @container_to   = CloudFilesTransfer::Container.new(@client_to.container)

    @container_from.objects.each do |path|
      object = @container_from.object(path)
      @container_to.transfer(object)
    end

    puts "Done."

    @client_to.container.refresh
  end

  def ask question
    STDOUT.puts question
    STDIN.gets.chomp
  end

end