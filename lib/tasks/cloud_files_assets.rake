namespace :cloudfiles do

  desc "Copy assets from one container to another container"
  task transfer: :environment do

    config = YAML.load_file("config/cloudfiles.yml")
    config = HashWithIndifferentAccess.new(config)

    username      = config[:origin][:username] rescue ask("Origin username:")
    api_key       = config[:origin][:api_key] rescue ask("Origin API key:")
    container     = config[:origin][:container] rescue ask("Origin container name:")
    snet          = config[:origin][:snet] rescue false
    @client_from  = CloudFilesTransfer::Client.new(
      username: username,
      api_key: api_key,
      container: container,
      snet: snet
    )

    username      = config["destination"]["username"] rescue ask("Destination username:")
    api_key       = config["destination"]["api_key"] rescue ask("Destination API key:")
    container     = config["destination"]["container"] rescue ask("Destination container name:")
    snet          = config["destination"]["snet"] rescue false
    @client_to    = CloudFilesTransfer::Client.new(
      username: username,
      api_key: api_key,
      container: container,
      snet: snet
    )

    @container_from = @client_from.container
    @container_to   = @client_to.container
    @assets = @container_from.objects

    jobs_count = ENV['jobs'].try(:to_i) || 4

    puts "#{@assets.size} files to copy."
    puts "Transfering #{jobs_count} files at a time. Here we go!"

    @assets = @assets.in_groups(jobs_count)

    Thread.abort_on_exception=true

    threads = jobs_count.times.map do |i|
      Thread.new(i) do |i|
        @assets[i].each do |path|
          CloudFilesTransfer::Transfer.copy!(@container_from, @container_to, path)
        end
      end
    end
    threads.each {|t| t.join}

    puts "Done."

    @client_to.container.refresh
  end

  def ask question
    STDOUT.puts question
    STDIN.gets.chomp
  end

end