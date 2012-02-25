require 'sinatra'
require 'slim'
require 'susy'

require_relative './views/helpers'
Dir['./config/*.rb'].each { |config| require_relative config }

set :js_assets, %w[zepto.min.js app.coffee]

set :pages, %w[about location workshops gallery contact]

get '/app.css' do
  sass :app
end

get '/' do
  slim :index
end

settings.pages.each do |page|
  get "/#{page}" do
    slim page.to_sym
  end

  get "/#{page}/:subpage" do
    slim "#{page}/#{params[:subpage]}".to_sym
  end
end
