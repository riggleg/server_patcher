require 'rubygems'
require 'bundler'
Bundler.require(:default)
require 'active_support/all'
require 'fileutils'

def add_load_path(path)
  $LOAD_PATH.unshift(path) unless $LOAD_PATH.include?(path)
end

add_load_path(File.join(File.dirname(__FILE__), 'lib'))
add_load_path(File.join(File.dirname(__FILE__), 'lib', 'commands'))
add_load_path(File.join(File.dirname(__FILE__), 'lib', 'jtests'))
add_load_path(File.join(File.dirname(__FILE__), 'lib', 'jpatches'))


$program_root = File.expand_path(File.dirname(__FILE__))
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
www_root = "/var/www/vhosts"
puts "Running command: #{command_name}"
server = JServer.new(www_root)
server.run_command(command_name.to_sym)
