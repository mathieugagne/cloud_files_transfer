namespace :cloud_files_assets do

  desc "Copy assets from one container to another container"
  task transfer: :environment do

    username      = ask("Transfer from username:")
    api_key       = ask("Transfer from API key:")
    fog_directory = ask("Transfer from container name:")
    @client_from  = CloudFilesClient.new(
      username: username,
      api_key: api_key,
      fog_directory: fog_directory
    )

    username      = ask("Transfer to username:")
    api_key       = ask("Transfer to API key:")
    fog_directory = ask("Transfer to container name:")
    @client_to    = CloudFilesClient.new(
      username: username,
      api_key: api_key,
      fog_directory: fog_directory
    )

    @container_from = @client_from.container
    @container_to   = CloudFilesContainer.new(@client_to.container)

    @container_from.objects.each do |path|
      AssetTransferWorker.perform_async(@container_from, @container, path)
    end

    puts "Done."

    @client_to.container.refresh
  end

  def ask question
    STDOUT.puts question
    STDIN.gets.chomp
  end

  def timestamp
    @timestamp ||= Time.now.strftime('%Y%m%d%H%M')
  end

end