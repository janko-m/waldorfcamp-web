class PagesController < ApplicationController
  def index
  end

  def about
  end

  def location
  end

  def contact
  end

  def pricing
  end

  def workshops
    @workshops = Workshop.all
  end

  def workshop
    @workshops = Workshop.all
    @workshop = Workshop.find(params[:workshop])
  end

  def gallery
    @camps = Camp.all
    @camp = Camp.find(params[:camp])
    @photos = @camp.photos(page: params[:page], per_page: 40)
  end
  caches_page :gallery

  def expire_cache
    expire_page gallery_path(camp: params[:camp], page: params[:page])
    redirect_to :back
  end
end
