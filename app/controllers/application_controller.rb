# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all
  helper_method :current_user_session, :current_user
  helper_method :current_user_is_admin?
  helper_method :get_gender_of
  filter_parameter_logging :password, :password_confirmation
  before_filter { |c| Authorization.current_user = c.current_user }
 
  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.record
  end
  
  def permission_denied  
    flash[:error] = "Sorry, you're not allowed to access that page."  
    redirect_to root_url  
  end  

  private
    def current_user_session
      return @current_user_session if defined?(@current_user_session)
      @current_user_session = UserSession.find
    end

    def get_gender_of(_user)
      _user.female ? "female" : "male"
    end
   
    def require_user
      unless current_user
        store_location
        flash[:notice] = "You must be logged in to access this page"
        redirect_to new_user_session_url
        return false
      end
    end

    def require_no_user
      if current_user
        store_location
        flash[:notice] = "You must be logged out to access this page"
        #redirect_to account_url
        redirect_to user_url(@current_user)
        return false
      end
    end
    
    def current_user_is_admin?
      not current_user.nil? and not current_user.roles.find(:all, :conditions => { :name => "admin" }).empty?
    end

    def store_location
      session[:return_to] = request.request_uri
    end
    
    def redirect_back_or_default(default)
      redirect_to(session[:return_to] || default)
      session[:return_to] = nil
    end
end
