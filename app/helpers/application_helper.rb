module ApplicationHelper
  def navigation_pages
    pages = [{:title => 'Home',      :action => 'index'},
             {:title => 'About',     :action => 'about'},
             {:title => 'Location',  :action => 'location'},
             {:title => 'Workshops', :action => 'workshops'},
             {:title => 'Gallery',   :action => 'gallery'},
             {:title => 'Contact',   :action => 'contact'}]

    pages.map! { |page| Struct.new(:title, :action).new(page[:title], page[:action]) }
  end

  def render_markdown(text)
    MyMarkdown.render(text).html_safe
  end
end
