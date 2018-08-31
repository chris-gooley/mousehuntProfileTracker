class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :require_hunter

  helper_method :current_hunter

  def current_hunter
    @current_hunter ||= Hunter.find(session[:hunter_id]) if session[:hunter_id]
  rescue
    reset_session
  end

  def current_hunter=(hunter)
    session[:hunter_id] = hunter.id
  rescue
    session[:hunter_id] = nil
  end

protected
  def require_hunter
    if !current_hunter
      session[:return_url] = request.path
      redirect_to login_path and return
    else
      # Disable caching (want to prevent back-button data viewing after logout)
      response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
      response.headers["Pragma"]        = "no-cache"
      response.headers["Expires"]       = "Fri, 01 Jan 1990 00:00:00 GMT"
    end
  end


end
