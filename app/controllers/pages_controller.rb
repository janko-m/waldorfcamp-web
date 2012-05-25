class PagesController < ApplicationController
  def index
  end

  def about
  end

  def location
  end

  def contact
  end

  def workshops
  end

  def workshop
  end

  def gallery
    @camps = Gallery.camps
    @current_camp = Gallery.current_camp(params[:camp])
    @photos = Gallery.photos_from_camp(@current_camp).map(&:small320!)
  end
  # caches_page :gallery

  def expire_camp_cache
    expire_page gallery_path(:camp => params[:camp])
    redirect_to :back
  end
end
