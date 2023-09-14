# app/models/user.rb
class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: Sso::Client.all.map(&:name)

  validates :username, presence: true, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true

  has_person_name

  def self.create_data_from_provider(provider_data)
    sso_client = Sso::Client.find_by(name: provider_data.provider)

    field_mapping = {
      email: sso_client.user_info_email_field,
      first_name: sso_client.user_info_first_name_field,
      last_name: sso_client.user_info_last_name_field,
    }

    attributes = {
      provider: provider_data.provider,
      uid: provider_data.uid
    }

    field_mapping.each do |user_attribute, provider_attribute|
      attributes[user_attribute] = provider_data.info[provider_attribute.to_sym]
    end

    where(provider: provider_data.provider, uid: provider_data.uid).first_or_create do |user|
      user.email = attributes[:email]
      user.password = Devise.friendly_token[0, 20]
      user.first_name = attributes[:first_name]
      user.last_name = attributes[:last_name]
      user.username = attributes[:email]
    end
  end
end
