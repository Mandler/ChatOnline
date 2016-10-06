class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!, :get_users, :default_message

  def get_users # In future get from friends
    @users = User.all
  end

  def default_message
    @message = Message.new
  end
end
