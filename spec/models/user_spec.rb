require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    before do
      FactoryBot.create(:sso_client)
    end

    let(:user_params) do
      FactoryBot.attributes_for(:user, provider: 'google_oauth2', uid: '987654321')
    end

    it 'should create a new user with valid params' do
      expect(User.new(user_params).save).to eq(true)
    end

    shared_examples 'a non-creating user' do |param_to_delete|
      it "should not create a new user when #{param_to_delete} is missing" do
        user_params.delete(param_to_delete)
        expect(User.new(user_params).save).to eq(false)
      end
    end

    context 'when email is missing' do
      include_examples 'a non-creating user', :email
    end

    context 'when first_name is missing' do
      include_examples 'a non-creating user', :first_name
    end

    context 'when last_name is missing' do
      include_examples 'a non-creating user', :last_name
    end

    context 'when username is missing' do
      include_examples 'a non-creating user', :username
    end

    context 'when email is not unique' do
      before do
        FactoryBot.create(:user, email: 'existing_email@example.com')
      end

      it 'should not create a new user' do
        user_params[:email] = 'existing_email@example.com'
        expect(User.new(user_params).save).to eq(false)
      end
    end

    context 'when username is not unique' do
      before do
        FactoryBot.create(:user, username: 'existing_username')
      end

      it 'should not create a new user' do
        user_params[:username] = 'existing_username'
        expect(User.new(user_params).save).to eq(false)
      end
    end
  end
end
