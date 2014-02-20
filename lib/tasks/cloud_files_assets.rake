namespace :cloud_files_assets do

  desc "Copy assets from one container to another container"
  task transfer: :environment do

    config    = YAML.load_file("config/cloudfiles.yml")

    username      = config["origin"]["username"] rescue ask("Origin username:")
    api_key       = config["origin"]["api_key"] rescue ask("Origin API key:")
    container     = config["origin"]["container"] rescue ask("Origin container name:")
    @client_from  = CloudFilesTransfer::Client.new(
      username: username,
      api_key: api_key,
      container: container
    )

    username      = config["destination"]["username"] rescue ask("Destination username:")
    api_key       = config["destination"]["api_key"] rescue ask("Destination API key:")
    container     = config["destination"]["container"] rescue ask("Destination container name:")
    @client_to    = CloudFilesTransfer::Client.new(
      username: username,
      api_key: api_key,
      container: container
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