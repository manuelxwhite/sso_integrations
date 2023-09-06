module Sso
  class Authorization < ApplicationRecord
    belongs_to :user
    belongs_to :sso_client

    validates :access_token, presence: true
    validates :user, presence: true
    validates :sso_client, presence: true

    def expired?
      expires_at.present? && expires_at <= Time.now
    end

    def refresh_access_token(new_access_token)
      update(access_token: new_access_token)
    end
  end
end
