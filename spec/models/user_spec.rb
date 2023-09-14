# spec/models/user_spec.rb
require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:sso_client) { FactoryBot.create(:sso_client) }

  describe 'create_data_from_provider' do
    context 'when the user does not exist' do
      it 'creates a new user' do
        provider_data = OmniAuth::AuthHash.new(
          provider: 'google_oauth2',
          uid: '123456',
          info: {
            email: 'test@example.com',
            first_name: 'John',
            last_name: 'Doe'
          }
        )

        expect do
          User.create_data_from_provider(provider_data)
        end.to change(User, :count).by(1)
      end

      it 'sets the user attributes correctly' do
        provider_data = OmniAuth::AuthHash.new(
          provider: 'google_oauth2',
          uid: '123456',
          info: {
            email: 'test@example.com',
            first_name: 'John',
            last_name: 'Doe'
          }
        )

        user = User.create_data_from_provider(provider_data)

        expect(user).to have_attributes(
          first_name: 'John',
          last_name: 'Doe',
          email: 'test@example.com',
          username: 'test@example.com', # Assuming you want to set username to the email
          provider: 'google_oauth2',
          uid: '123456'
        )
      end
    end

    context 'when the user already exists' do
      it 'does not create a new user' do
        provider_data = OmniAuth::AuthHash.new(
          provider: 'google_oauth2',
          uid: '123456',
          info: {
            email: 'test@example.com',
            first_name: 'John',
            last_name: 'Doe'
          }
        )

        User.create_data_from_provider(provider_data) # Create the user initially

        expect do
          User.create_data_from_provider(provider_data)
        end.not_to change(User, :count)
      end

      it 'returns the existing user' do
        provider_data = OmniAuth::AuthHash.new(
          provider: 'google_oauth2',
          uid: '123456',
          info: {
            email: 'test@example.com',
            first_name: 'John',
            last_name: 'Doe'
          }
        )

        existing_user = User.create_data_from_provider(provider_data) # Create the user initially
        user = User.create_data_from_provider(provider_data)

        expect(user).to eq(existing_user)
      end
    end
  end
end
