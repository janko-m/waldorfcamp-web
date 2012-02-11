require 'sinatra'
require 'sinatra/activerecord'
require 'susy'

$:.unshift settings.root if $:.first != settings.root

# Personal requirings
require 'db/models'
require 'views/helpers'
Dir['config/*.rb'].each { |config| require config }

set :database, "sqlite://development.db"

set :js_assets, %w[zepto.min.js app.coffee]

get '/app.css' do
  sass :app
end

get '/' do
  haml :index
end

get '/about' do
  haml :about
end

get '/location' do
  haml :location
end

get '/workshops' do
  haml :workshops
end

get '/gallery' do
  haml :gallery
end

get '/contact' do
  haml :contact
end
