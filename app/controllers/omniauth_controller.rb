class OmniauthController < Devise::OmniauthCallbacksController
  skip_before_action :verify_authenticity_token

  def generic_callback
    provider_name = request.env['omniauth.auth'].provider
    @user = User.create_data_from_provider(request.env['omniauth.auth'])

    if @user.persisted?
      handle_successful_sign_in(provider_name)
    else
      handle_sign_in_failure(provider_name)
    end
  end

  def failure
    flash[:error] = 'There was a problem signing you in. Please register or try signing in later.'
    redirect_to new_user_registration_url
  end

  private

  def handle_successful_sign_in(provider_name)
    sign_in_and_redirect @user
    set_flash_message(:notice, :success, kind: provider_name.capitalize) if is_navigational_format?
  end

  def handle_sign_in_failure(provider_name)
    flash[:error] = "There was a problem signing you in through #{provider_name.capitalize}. " \
     'Please register or try signing in later.'
    redirect_to new_user_registration_url
  end
end
