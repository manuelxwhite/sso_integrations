module Sso
  class Client < ApplicationRecord
    validates :name, :redirect_uri, :site_url, :token_url, :authorize_url, :user_info_url, :user_info_fields,
              :user_info_id_field, :user_info_username_field, :user_info_email_field, :user_info_first_name_field,
              :user_info_last_name_field, :open_id_connect_endpoint, presence: true

    def omniauth_config
      {
        name:,
        client_id:,
        client_secret:,
        redirect_uri:,
        issuer: open_id_connect_endpoint,
        client_options:
      }.merge(static_fields).merge(custom_fields)
    end

    def omniauth_provider
      OmniAuth::Strategies::OpenIDConnect.new(omniauth_config)
    end

    def has_client_and_secret?
        client_id.present? && client_secret.present?
    end

    private

    def client_id
      ENV["#{name.upcase}_CLIENT_ID"]
    end

    def client_secret
      ENV["#{name.upcase}_SECRET"]
    end

    def static_fields
      {
        strategy: 'openid_connect',
        scope: 'openid email profile',
        response_type: 'code',
        discovery: true
      }
    end


    def client_options
      {
        identifier: client_id,
        secret: client_secret,
        redirect_uri:,
        authorization_endpoint: authorize_url,
        token_endpoint: token_url,
        user_info_endpoint: user_info_url,
        discovery: true
      }
    end

    def custom_fields
      {
        uid_field: user_info_id_field,
        name_field: user_info_username_field,
        email_field: user_info_email_field,
        first_name_field: user_info_first_name_field,
        last_name_field: user_info_last_name_field
      }
    end
  end
end
