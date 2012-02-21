# Ubuntu fix
ENV['TMPDIR'] ||= "/tmp"

require './app'
run Sinatra::Application
