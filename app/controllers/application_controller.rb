class ApplicationController < ActionController::Base
  allow_browser versions: :modern
  stale_when_importmap_changes

  helper_method :current_user, :logged_in?

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.html do
        redirect_to root_path, alert: exception.message
      end

      format.turbo_stream do
        redirect_to root_path, alert: exception.message
      end

      format.json { head :forbidden }
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
