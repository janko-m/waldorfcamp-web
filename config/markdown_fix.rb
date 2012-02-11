require 'redcarpet'

set :markdown, Redcarpet::Markdown.new(Redcarpet::Render::HTML)

module Haml::Filters::Markdown
  include Haml::Filters::Base
  lazy_require "redcarpet"

  def render(text)
    settings.markdown.render(text)
  end
end
