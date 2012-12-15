require "json"
require "nokogiri"

class Forwarder < ActionMailer::Base
  default from: "Outward Bound <#{ENV["SENDGRID_USERNAME"]}>", to: "janko.marohnic@gmail.com"

  def forward(params)
    set_attachments(params)
    fix_html(params)

    @params = params
    mail(subject: params[:subject]).deliver
  end

  def set_attachments(params)
    JSON.parse(params[:"attachment-info"]).each do |name, info|
      attachments[info["filename"]] = params[name].read
    end
  end

  def fix_html(params)
    document = Nokogiri::HTML(params[:html])
    document.search(:img).each do |img|
      img.remove if img[:src] =~ /^cid:[\w-]+$/
    end
    params[:html] = document.to_html
  end
end
