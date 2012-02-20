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

set :pages, %w[about location workshops gallery contact]

get '/app.css' do
  sass :app
end

get '/' do
  haml :index
end

settings.pages.each do |page|
  get "/#{page}" do
    haml page.to_sym
  end

  get "/#{page}/:subpage" do
    haml "#{page}/#{params[:subpage]}".to_sym
  end
end
