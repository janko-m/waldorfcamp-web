require "json"
require "nokogiri"

class SendgridEmailParser
  def initialize(email)
    @email = email
  end

  def result
    parse
    @email
  end

  def parse
    fix_html
    fix_attachments
    @email[:to] = @email[:to][/[^\w]+@waldorfcamp\.net/]
  end

  private

  def fix_attachments
    @email[:attachments] = {}
    if @email[:"attachment-info"]
      JSON.parse(@email[:"attachment-info"]).each do |name, info|
        @email[:attachments][info["filename"]] = @email[name].read
      end
    end
  end

  def fix_html
    document = Nokogiri::HTML(@email[:html])
    document.search(:img).each do |img|
      img.remove if img[:src] =~ /^cid:[\w-]+$/
    end
    @email[:html] = document.to_html
  end
end
