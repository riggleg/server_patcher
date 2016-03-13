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
    #paths_before = Pathname.new(server_www_root).children.select { |c| c.directory? && !bad_dirs.include?(c.basename) }
    paths = Pathname.new(server_www_root).children.select { |c| c.directory? && !bad_dirs.include?(c.basename.to_s) }.map{|p| p + "httpdocs" }.map{|p| p.to_s}
    puts paths.inspect
    # paths_before.each do |p|
    #   puts p
    #   puts p.basename.inspect
    #   puts bad_dirs.include?(p.basename.to_s)
    # end
    return paths
  end
  def bad_dirs
    r = []
    r << "fs"
    r << "fs-passwd"
    r << "system"
    r << "default"
    r << "chroot"
    return r
  end
end
