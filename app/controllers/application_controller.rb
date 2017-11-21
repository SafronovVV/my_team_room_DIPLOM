class ApplicationController < ActionController::Base

  before_action :authenticate_user!
  protect_from_forgery with: :exception
  before_action :get_messages

  private

  def get_messages
    @messages = Message.all
  end
end
