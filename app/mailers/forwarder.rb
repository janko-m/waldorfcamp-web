require_relative "forwarder/sendgrid_email_parser"

class Forwarder < ActionMailer::Base
  def forward(params)
    @email = SendgridEmailParser.new(params).result
    @email[:attachments].each { |filename, content| attachments[filename] = content }

    p @email[:html]
    p @email[:text]

    mail(
      from: @email[:from],
      to: "janko.marohnic@gmail.com",
      subject: @email[:subject],
    ).deliver
  end
end
