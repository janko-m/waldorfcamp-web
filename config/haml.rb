require 'haml'
require 'redcarpet'

class SmartHTMLRenderer < Redcarpet::Render::HTML
  include Redcarpet::Render::SmartyPants
end
module Haml::Filters::Markdown
  include Haml::Filters::Base
  lazy_require "redcarpet"

  def render(text)
    markdown = Redcarpet::Markdown.new SmartHTMLRenderer,
      :smart => true
    markdown.render(text)
  end
end
