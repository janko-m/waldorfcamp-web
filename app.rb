require 'sinatra'
require 'susy'

Dir['./config/*.rb'].each { |config| require config }
Dir['./lib/*.rb'].each { |lib| require lib }
require './views/helpers'

set :js_assets, %w[jquery.mousewheel-3.0.6.pack.js jquery.fancybox.pack.js app.coffee]

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
