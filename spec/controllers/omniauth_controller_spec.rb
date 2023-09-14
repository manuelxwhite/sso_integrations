require 'rails_helper'

RSpec.describe OmniauthController, type: :controller do
  let(:user) { FactoryBot.create(:user) }

  before do
    request.env['devise.mapping'] = Devise.mappings[:user]
  end

  describe 'dynamic OAuth callbacks' do
    let(:sso_clients) { Sso::Client.all }

    before do
      sso_clients.each do |client|
        next unless client.client_and_secret?

        OmniAuth.config.mock_auth[client.name.to_sym] = OmniAuth::AuthHash.new(
          provider: client.name,
          uid: '123456',
          info: { email: 'test@example.com', name: 'Test User' }
        )
      end
    end

    context 'when a valid user is created' do
      it 'signs in the user and redirects with a success flash message for each provider' do
        sso_clients.each do |client|
          next unless client.client_and_secret?

          expect(User).to receive(:create_data_from_provider).with(instance_of(OmniAuth::AuthHash)).and_return(user)
          expect(user).to receive(:persisted?).and_return(true)

          get "#{client.name.downcase}_omniauth_callback"
          expect(response).to redirect_to(root_path)
          expect(flash[:notice]).to eq("Successfully signed in through #{client.name.capitalize}")
        end
      end
    end

    context 'when user creation fails' do
      it 'redirects to registration with an error flash message for each provider' do
        sso_clients.each do |client|
          next unless client.client_and_secret?

          expect(User).to receive(:create_data_from_provider).with(instance_of(OmniAuth::AuthHash)).and_return(user)
          expect(user).to receive(:persisted?).and_return(false)

          get "#{client.name.downcase}_omniauth_callback"
          expect(response).to redirect_to(new_user_registration_path)
          expect(flash[:error]).to eq("There was a problem signing you in through #{client.name.capitalize}. Please register or try signing in later.")
        end
      end
    end
  end

end
