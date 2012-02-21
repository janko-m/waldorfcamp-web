
ENV['TMPDIR'] = "/tmp" unless ENV['TMPDIR']

require './app'
run Sinatra::Application
