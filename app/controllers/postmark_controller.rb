class PostmarkController < ApplicationController
  http_basic_authenticate_with name: "postmark", password: "postmark"

  def inbound
    if EmailToReminderReceiver.receive(request)
      render :json => { :status => 'ok' }
    else
      render :json => { :status => 'rejected' }, :status => 400
    end
  end

end
