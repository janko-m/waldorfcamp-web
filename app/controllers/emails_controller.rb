require "pp"

class EmailsController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def receive
    Forwarder.forward(params)
    head 200
  end
end
