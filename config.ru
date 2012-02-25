# Ubuntu fix
ENV['TMPDIR'] ||= "/tmp"

require_relative './app'
run Sinatra::Application
