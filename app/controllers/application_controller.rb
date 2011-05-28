class ApplicationController < ActionController::Base
  protect_from_forgery

  def check_if_admin
    if user_signed_in? and !current_user.admin 
      redirect_to root_path, :alert => "You cannot view this page."
    end
  end
end
