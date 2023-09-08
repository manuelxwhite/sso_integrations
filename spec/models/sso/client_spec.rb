require 'rails_helper'

RSpec.describe Sso::Client, type: :model do
  describe 'validations' do
    let(:client_params) { FactoryBot.attributes_for(:sso_client) }

    it 'creates a record with valid params' do
      expect { described_class.create(client_params) }.to change { described_class.count }.by(1)
    end

    shared_examples 'a non-creating client' do |params|
      it 'does not create a record' do
        expect { described_class.create(client_params.merge(params)) }.to_not(change { described_class.count })
      end
    end

    context 'when name is not present' do
      include_examples 'a non-creating client', name: nil
    end

    context 'when redirect_uri is not present' do
      include_examples 'a non-creating client', redirect_uri: nil
    end

    context 'when site_url is not present' do
      include_examples 'a non-creating client', site_url: nil
    end

    context 'when token_url is not present' do
      include_examples 'a non-creating client', token_url: nil
    end

    context 'when authorize_url is not present' do
      include_examples 'a non-creating client', authorize_url: nil
    end

    context 'when user_info_url is not present' do
      include_examples 'a non-creating client', user_info_url: nil
    end

    context 'when user_info_fields is not present' do
      include_examples 'a non-creating client', user_info_fields: nil
    end

    context 'when user_info_id_field is not present' do
      include_examples 'a non-creating client', user_info_id_field: nil
    end

    context 'when user_info_username_field is not present' do
      include_examples 'a non-creating client', user_info_username_field: nil
    end

    context 'when user_info_email_field is not present' do
      include_examples 'a non-creating client', user_info_email_field: nil
    end

    context 'when user_info_first_name_field is not present' do
      include_examples 'a non-creating client', user_info_first_name_field: nil
    end

    context 'when user_info_last_name_field is not present' do
      include_examples 'a non-creating client', user_info_last_name_field: nil
    end

    context 'when open_id_connect_endpoint is not present' do
      include_examples 'a non-creating client', open_id_connect_endpoint: nil
    end
  end

  describe 'on save' do
    it 'calls save_sso_clients_yml' do
      expect_any_instance_of(described_class).to receive(:save_sso_clients_yml)
      FactoryBot.create(:sso_client)
    end

    context 'when sso_clients.yml already exists' do
      let(:existing_sso_client) { FactoryBot.create(:sso_client, name: 'existing_client') }

      it 'updates the file' do
        yml_file = Rails.root.join('config', 'sso_clients.yml')
        expect do
          existing_sso_client.update(name: 'updated_client')
        end.to(change { File.mtime(yml_file) })
      end
    end
  end
end
