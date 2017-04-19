module SessionsHelper
  
  def log_in(user)
    session[:user_id] = user.id
  end
  
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
  
  def logged_in?
    !current_user.nil?
  end
  
  def admin?
    !current_user.nil? and current_user.admin
  end
  
  def log_out
    session.delete(:user_id)
    @current_user = nil
  end
  
  def authenticate_user
    if logged_in?
      return
    else
      redirect_to login_url(returnto: request.fullpath)
    end
  end
  
  def authenticate_specific_user user
    if admin?
      return
    elsif current_user == user 
      return
    end
    flash[:"alert-danger"] = 'Only administrators can perform this action'
    begin
      redirect_to :back
    rescue ActionController::RedirectBackError
      redirect_to root_path
    end
  end
  
  def authenticate_specific_users users
    if admin?
      return
    end
    users.each do |user|
      if current_user == user 
        return
      end
    end
    flash[:"alert-danger"] = 'Only administrators can perform this action'
    begin
      redirect_to :back
    rescue ActionController::RedirectBackError
      redirect_to root_path
    end
  end
  
  def authenticate_admin
    if admin?
      return
    else
      flash[:"alert-danger"] = 'Only administrators can perform this action'
      begin
        redirect_to :back
      rescue ActionController::RedirectBackError
        redirect_to root_path
      end
    end
  end
  
  
end
