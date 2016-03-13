class JServer
  attr_accessor :server_www_root
  def initialize(www_root)
    self.server_www_root = www_root
  end
  def run_command(command)
    sites = []
    site_paths.each do |sp|
      sites << JSite.new(sp)
    end
    sites.each do |s|
      comm = JCommand.get_command(command.to_sym)
      raise "No command found for #{command}" if comm.nil?
      comm.process(s)
    end
  end
  def site_paths
    paths = Pathname.new(server_www_root).children.select { |c| c.directory? }.map{|p| p + "httpdocs" }.map{|p| p.to_s}
    puts paths.inspect
    return paths
  end
end
