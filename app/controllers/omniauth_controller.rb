class OmniauthController < Devise::OmniauthCallbacksController
  sso_clients.each do |client|
    next unless client.client_and_secret?

    define_method client.name.downcase.to_sym do
      handle_oauth_callback(client.name.downcase)
    end
  end

  def failure
    flash[:error] = 'There was a problem signing you in. Please register or try signing in later.'
    redirect_to new_user_registration_url
  end

  private

  def handle_oauth_callback(provider)
    @user = User.create_data_from_provider(request.env['omniauth.auth'])
    if @user.persisted?
      sign_in_and_redirect @user
      set_flash_message(:notice, :success, kind: provider.capitalize) if is_navigational_format?
    else
      flash[:error] =
        "There was a problem signing you in through #{provider.capitalize}. Please register or try signing in later."
      redirect_to new_user_registration_url
    end
  end

  def sso_clients
    Sso::Client.all
  end
end
