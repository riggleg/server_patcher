class ServerInfo < JCommand
  command_name :server_info
  def self.process(site)
    puts "Site Directory: #{site.root_directory}"
    puts "Site Version: #{site.version}"
  end
end
