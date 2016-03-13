def add_load_path(path)
  $LOAD_PATH.unshift(path) unless $LOAD_PATH.include?(path)
end

add_load_path(File.join(File.dirname(__FILE__), 'lib'))
add_load_path(File.join(File.dirname(__FILE__), 'lib', 'commands'))
add_load_path(File.join(File.dirname(__FILE__), 'lib', 'jtests'))
add_load_path(File.join(File.dirname(__FILE__), 'lib', 'jpatches'))

puts $LOAD_PATH.inspect

require 'jserver.rb'
require 'jsite.rb'
require 'jcommand.rb'
require 'server_info.rb'
require 'jtest.rb'
require 'version_test.rb'
require "pathname"
require "digest/md5"
require "jpatch.rb"
require 'file_patch.rb'
require 'session_patch.rb'

command_name = ARGV[0]
www_root = ARGV[1]
puts command_name
server = JServer.new(www_root)
server.run_command(command_name.to_sym)
