class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :signed_in?, :current_user
  
  before_action :set_tracking_cookie
  
  def set_tracking_cookie
    create_anonymous_user unless cookies[:user_uuid]
  end
  
  def create_anonymous_user
    cookies.permanent[:user_uuid] = SecureRandom.uuid
    @anon_user = User.new(uuid: cookies[:user_uuid])
    @anon_user.save(validate: false)
    @anon_user.name = "Guest "+@anon_user.id.to_s
    @anon_user.save(validate: false)
  end
  
  def sign_in(user)
    cookies[:user_uuid] = user.uuid
  end
  
  def signed_in?
    if !current_user.nil?
      if current_user.email
        return true
      end
    end
    return false
  end
  
  def current_user
    current_user ||= User.find_by(uuid: cookies[:user_uuid])
  end
  
  def sign_out
    cookies.delete(:user_uuid)
  end
end
