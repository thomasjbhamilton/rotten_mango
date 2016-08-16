class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  protected

  helper_method :current_user

  def restrict_access
    if !current_user
      flash[:alert] = "You must log in."
      redirect_to new_session_path
    end
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def admin_check
    if  current_user.nil? || !current_user.admin
      flash[:alert] = "You must be an Admin to enter."
      redirect_to new_session_path
    end
  end



end
