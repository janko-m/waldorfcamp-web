WaldorfCamp::Application.routes.draw do
  root :to => "pages#index"

  get "/", :to => "pages#index", :as => :index
  get "/about", :to => "pages#about"
  get "/location", :to => "pages#location"
  get "/contact", :to => "pages#contact"
  get "/workshops", :to => "pages#workshops"
  get "/workshops/:workshop", :to => "pages#workshop"

  match "/gallery/:camp/(:page)/expire_cache" => "pages#expire_camp_cache"
  get "/gallery/:camp/(:page)", :to => "pages#gallery", :as => :gallery
  get "/gallery", :to => redirect("/gallery/2001-badija")

  match "/404", :to => "errors#not_found"
  match "/500", :to => "errors#internal_server_error"
end
