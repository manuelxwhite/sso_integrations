require 'rails_helper'

RSpec.describe 'home/index', type: :view do
  include Devise::Test::ControllerHelpers  # Include Devise test helpers

  describe 'when logged in' do
    let(:user) { FactoryBot.create(:user) }
    before do
      allow(view).to receive(:user_signed_in?).and_return(true)
      allow(view).to receive(:current_user).and_return(FactoryBot.create(:user))
    end

    it 'displays the user\'s email' do
      render
      expect(rendered).to match(/john.doe@example.com/)
    end
  end
end
