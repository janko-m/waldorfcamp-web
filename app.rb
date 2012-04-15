require 'sinatra'
require 'susy'
require 'haml'

require 'config/compass_config'
require 'config/custom_logger'
require 'config/haml_config'
require 'config/sinatra_boilerplate'

require 'lib/flickr'
require 'lib/partials'

require 'views/helpers'

set :js_assets, %w[jquery.mousewheel-3.0.6.pack.js jquery.fancybox.pack.js app.coffee]

get '/app.css' do
  sass :app
end

get('/')          { haml :index }
get('/about')     { haml :about }
get('/location')  { haml :location }
get('/contact')   { haml :contact }

get('/workshops') { haml :workshops }
[:yoga, :painting, :circus, :singing].each do |workshop|
  get "/workshops/#{workshop}" do
    @title = workshop.to_s.capitalize
    haml :"workshops/#{workshop}"
  end
end

get '/gallery' do
  redirect '/gallery/2001-badija'
end

get '/gallery/:camp' do
  @camps = Flickr.sets_from_user('66667715@N07')
  @camps.sort_by! { |camp| camp.title[/\d{4}$/] }
  current_camp_title = params[:camp].split('-').map(&:capitalize).join(', ')
  @current_camp = @camps.find { |camp| camp.title == current_camp_title }
  haml :gallery
end

error do
  haml :error
end
