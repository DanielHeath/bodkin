class PostmarkController < ApplicationController
  http_basic_authenticate_with name: "postmark", password: "postmark"

  protect_from_forgery :except => :inbound

  def inbound
    if EmailToReminderReceiver.receive(params["postmark"])
      render :json => { :status => 'ok' }
    else
      render :json => { :status => 'rejected' }, :status => 400
    end
  end

end
