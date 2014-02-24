WaldorfCamp::Application.routes.draw do
  root to: "pages#index"

  controller :pages do
    get "", to: :index
    get "about"
    get "location"
    get "workshops"
    get "workshops/:workshop", to: :workshop, as: :workshop
    get "gallery", to: redirect("/gallery/2001-badija")
    get "gallery/:camp/(:page)", to: :gallery, as: :gallery
    delete "gallery/:camp/(:page)/expire_cache", to: :expire_cache, as: :expire_cache
    get "contact"
    get "pricing"
  end

  # mount SendgridEmailForwarder::Engine, at: ""

  match "404", to: "errors#not_found"
  match "500", to: "errors#internal_server_error"
end
