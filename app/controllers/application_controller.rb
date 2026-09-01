class ApplicationController < ActionController::Base
  allow_browser versions: :modern
  stale_when_importmap_changes
  ## generated application infrastructure

  helper_method :current_user, :logged_in?

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.html do
        redirect_to root_path, alert: exception.message
      end ## normal web request

      format.turbo_stream do
        redirect_to root_path, alert: exception.message
      end ## turbo web request like form submissions and page updates

      format.json { head :forbidden } ## usually requested by another program - returns a 403 Forbidden status w/ no response body
    end
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def logged_in?
    current_user.present?
  end

  def require_user
    return if logged_in?

    redirect_to root_path, alert: "You must log in to access."
  end
end
## remember - defining :current_user and logged_in? as helper methods here makes them available in views
## current_user method -- checks whether the session contains a user ID, looks up that user in db.
## Stores result in @current_user for reuse during the same request
## Returns nil when no authenticated user exists
## raises accessdenied for when a user attempts an unauthorized action
