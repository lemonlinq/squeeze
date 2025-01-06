class Users::RegistrationsController < Devise::RegistrationsController
  def create
    super do |resource|
      if resource.persisted?
        if resource.active_for_authentication?
          flash[:notice] = "Your account has been successufully created!"
        else
          flash[:notice] = "There was an error creating your account"
        end
        flash.keep(:notice) # Ensure the notice message persists after the redirect
      else
        flash[:alert] = resource.errors.full_messages.join(", ")
      end
    end
  end

  protected

  def sign_up_params
    params.require(:user).permit(:first_name, :last_name, :portfolio_link, :email, :password, :password_confirmation, :terms_of_service)
  end

  def after_inactive_sign_up_path_for(resource)
    new_user_session_path
  end
end
