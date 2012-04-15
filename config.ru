# Ubuntu fix
ENV['TMPDIR'] ||= "/tmp"

['.', 'lib'].each do |folder|
  $:.unshift(File.expand_path(folder, File.dirname(__FILE__)))
end

require './app'
run Sinatra::Application
