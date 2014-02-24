module ApplicationHelper
  def navigation_pages
    pages = [{:title => 'About',     :route => "/about"},
             {:title => 'Location',  :route => "/location"},
             {:title => 'Workshops', :route => "/workshops"},
             {:title => 'Gallery',   :route => "/gallery"},
             {:title => 'Contact',   :route => "/contact"},
             {:title => 'Pricing',   :route => "/pricing"}]

    pages.map! do |page|
      page_class = Struct.new(:title, :route)
      page_class.new(page[:title], page[:route])
    end
  end

  def icon(name)
    raw content_tag(:i, "", class: "icon-#{name}")
  end

  def contact_link(string, options = {})
    mail_to "matija.marohnic@gmail.com, janko.marohnic@gmail.com", string, {target: "_blank"}.merge(options)
  end

  def render_markdown(text)
    MyMarkdown.render(text).html_safe
  end
end
