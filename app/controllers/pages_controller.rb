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
    @camp_titles = Camp.all.map(&:title)
    @current_camp = Camp.find_by_url_title(params[:camp])
    @photos = @current_camp.photos(:page => params[:page], :per_page => 40)
  end
  caches_page :gallery

  def expire_camp_cache
    expire_page gallery_path(:camp => params[:camp])
    redirect_to :back
  end
end
