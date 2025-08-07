class Users::RegistrationsController < Devise::RegistrationsController
  protected

  # This disables automatic login after signup
  def sign_up(resource_name, resource)
    # Do nothing
  end

  # Redirect to login page after successful signup
  def after_sign_up_path_for(resource)
    new_user_session_path
  end
end
