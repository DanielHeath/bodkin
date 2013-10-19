class PostmarkController < ApplicationController
  http_basic_authenticate_with name: "postmark", password: "postmark"

  protect_from_forgery :except => :inbound

  def inbound
    request.body.rewind
    if EmailToReminderReceiver.receive(request)
      render :json => { :status => 'ok' }
    else
      render :json => { :status => 'rejected' }, :status => 400
    end
  end

end