require 'sinatra'
require 'susy'
require 'haml'

require 'config/compass_config'
require 'config/custom_logger'
require 'config/haml_config'
require 'config/sinatra_boilerplate'

set :js_assets, %w[jquery.mousewheel-3.0.6.pack.js jquery.fancybox.pack.js app.coffee]
require 'lib/flickr'
require 'lib/partials'

require 'views/helpers'

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
