class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  after_action :link_session_links_to_user, if: :user_signed_in?

  def authenticate_admin!
    authenticate_user!
    redirect_to :somewhere, status: :forbidden unless current_user.admin?
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :portfolio_link])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :portfolio_link])
  end

  def link_session_links_to_user
    session_links = Link.where(session_id: session.id.to_s)
    return if session_links.empty?

    session_links.update_all(user_id: current_user.id, session_id: nil)
    Rails.logger.info "Migrated #{session_links.count} links from session to user: #{current_user.id}"
  end

  def clear_session_links
    session[:id] = nil # Clear session ID to prevent future association
    reset_session
    Rails.logger.info "Cleared session data after logout."
  end

  def after_sign_out_path_for(resource_or_scope)
    # Optionally clear session links or redirect to a specific page
    session[:id] = nil # Clear session ID for security
    root_path
  end

end
