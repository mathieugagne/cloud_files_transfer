namespace :cloud_files_assets do

  desc "Copy assets from one container to another container"
  task transfer: :environment do

    config        = YAML.load_file("config/cloudfiles.yml")
    username      = config["origin"]["username"] rescue ask("Origin username:")
    api_key       = config["origin"]["api_key"] rescue ask("Origin API key:")
    fog_directory = config["origin"]["fog_directory"] rescue ask("Origin container name:")

    @client_from  = CloudFilesTransfer::Client.new(
      username: username,
      api_key: api_key,
      fog_directory: fog_directory
    )

    username      = config["destination"]["username"] rescue ask("Destination username:")
    api_key       = config["destination"]["api_key"] rescue ask("Destination API key:")
    fog_directory = config["destination"]["fog_directory"] rescue ask("Destination container name:")

    @client_to    = CloudFilesTransfer::Client.new(
      username: username,
      api_key: api_key,
      fog_directory: fog_directory
    )

    @container_from = @client_from.container
    @container_to   = CloudFilesTransfer::Container.new(@client_to.container)

    @container_from.objects.each do |path|
      CloudFilesTransfer::Transfer.copy!(@container_from, @container_to, path)
    end

    puts "Done."

    @client_to.container.refresh
  end

  def ask question
    STDOUT.puts question
    STDIN.gets.chomp
  end

end