module ApplicationHelper
  def navigation_pages
    pages = [{:title => 'Home',      :route => "/"},
             {:title => 'About',     :route => "/about"},
             {:title => 'Location',  :route => "/location"},
             {:title => 'Workshops', :route => "/workshops"},
             {:title => 'Gallery',   :route => "/gallery"},
             {:title => 'Contact',   :route => "/contact"}]

    pages.map! do |page|
      page_class = Struct.new(:title, :route)
      page_class.new(page[:title], page[:route])
    end
  end

  def render_markdown(text)
    MyMarkdown.render(text).html_safe
  end
end
