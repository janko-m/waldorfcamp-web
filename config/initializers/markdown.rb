class SmartHTMLRenderer < Redcarpet::Render::HTML
  include Redcarpet::Render::SmartyPants
end

module MyMarkdown
  def self.render(text)
    markdown = Redcarpet::Markdown.new SmartHTMLRenderer, :smart => true
    markdown.render(text)
  end
end
