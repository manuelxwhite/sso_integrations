class User < ApplicationRecord
  # ... (other code)

  def self.create_data_from_provider(provider_data)
    sso_client = Sso::Client.find_by(name: provider_data.provider)

    user_attributes = map_provider_attributes(provider_data, sso_client)

    where(provider: provider_data.provider, uid: provider_data.uid)
      .first_or_create(user_attributes) do |user|
      user.email = user_attributes[:email]
      user.password = Devise.friendly_token[0, 20]
      user.username = user_attributes[:email]
    end
  end

  def self.map_provider_attributes(provider_data, sso_client)
    field_mapping = {
      email: sso_client&.user_info_email_field,
      first_name: sso_client&.user_info_first_name_field,
      last_name: sso_client&.user_info_last_name_field
    }

    field_mapping.transform_keys(&:to_sym)
                 .transform_values { |value| provider_data.info[value.to_sym] }
                 .compact
                 .merge(provider: provider_data.provider, uid: provider_data.uid)
  end
end
