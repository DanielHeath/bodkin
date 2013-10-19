class WelcomeController < ApplicationController
  def index
    @reminder = Reminder.new
  end
end
