$:.unshift File.expand_path('..', __FILE__)

ENV['TMPDIR'] = "/tmp" unless ENV['TMPDIR']

require 'app'
run Sinatra::Application
